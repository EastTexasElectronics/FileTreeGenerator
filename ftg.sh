#!/bin/zsh 
#Change zsh to bash if you want to use the bash version

# Initialize exclude patterns array and other variables
exclude_patterns=()
output_location=""
version="1.0.0" # Add version information
author="https://github.com/easttexaselectronics"

# Function to show usage
show_usage() {
    echo "Usage: ft [-e pattern1,pattern2,...] [-o output_location] [-i] [-h] [-v]"
    echo "Options:"
    echo "  -e, --exclude      Exclude directories or files (comma-separated) (e.g., -e .git,node_modules)"
    echo "  -o, --output       Specify a different output location"
    echo "  -i, --interactive  Interactive mode for excluding directories or files"
    echo "  -h, --help         Show this help message and exit"
    echo "  -v, --version      Show version information and exit"
    exit 1
}

# Function to show version
show_version() {
    echo "ft version $version"
    exit 0
}

# Interactive mode to select exclude patterns
interactive_mode() {
    echo "Interactive mode: Select directories or files to exclude"
    local items=($(ls -d */ 2>/dev/null))
    local PS3="Enter the number of the item to exclude (or type 'exit' to finish): "
    select item in "${items[@]}" "Exit"; do
        if [[ "$item" == "Exit" ]]; then
            break
        elif [[ -n "$item" ]]; then
            exclude_patterns+=("${item%/}")
            echo "Excluded: $item"
        else
            echo "Invalid selection"
        fi
    done
}

# Parse command line arguments
while getopts ":e:o:ihv-:" opt; do
    case $opt in
    e)
        IFS=',' read -rA exclude_patterns <<<"$OPTARG"
        ;;
    o)
        output_location="$OPTARG"
        ;;
    i)
        interactive_mode
        ;;
    h)
        show_usage
        ;;
    v)
        show_version
        ;;
    -)
        case "${OPTARG}" in
        exclude)
            val="${!OPTIND}"
            OPTIND=$(($OPTIND + 1))
            IFS=',' read -rA exclude_patterns <<<"$val"
            ;;
        output)
            val="${!OPTIND}"
            OPTIND=$(($OPTIND + 1))
            output_location="$val"
            ;;
        interactive)
            interactive_mode
            ;;
        help)
            show_usage
            ;;
        version)
            show_version
            ;;
        *)
            echo "Invalid option: --${OPTARG}" >&2
            show_usage
            ;;
        esac
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        show_usage
        ;;
    :)
        echo "Option -$OPTARG requires an argument." >&2
        show_usage
        ;;
    esac
done

# Common directories to exclude
exclude_patterns+=(node_modules)      # Node.js
exclude_patterns+=(.next)             # Next.js
exclude_patterns+=(.vscode)           # VS Code
exclude_patterns+=(.idea)             # JetBrains IDEs
exclude_patterns+=(.git)              # Git
exclude_patterns+=(target)            # Rust
exclude_patterns+=(Cargo.lock)        # Rust
exclude_patterns+=(zig-cache zig-out) # Zig
exclude_patterns+=(vendor go.sum)     # Go
exclude_patterns+=(DerivedData)       # Swift
exclude_patterns+=(.svelte-kit)       # SvelteKit

# Filter and validate exclude patterns
valid_exclude_patterns=()
for pattern in "${exclude_patterns[@]}"; do
    if [[ -e $pattern || "$pattern" == *.* ]]; then
        valid_exclude_patterns+=("$pattern")
    fi
done
exclude_patterns=("${valid_exclude_patterns[@]}")

# Function to check if a file or directory should be excluded
should_exclude() {
    local name="$1"
    for pattern in "${exclude_patterns[@]}"; do
        if [[ "$name" == "$pattern" ]]; then
            return 0
        fi
    done
    return 1
}

# Function to get entries in a directory
get_entries() {
    local path="$1"
    echo "$path"/*(N)
}

# Function to print entry
print_entry() {
    local name="$1"
    local type="$2"
    local indent="$3"
    local is_last="$4"

    if [ "$is_last" -eq 1 ]; then
        echo "${indent}└── [$type] $name"
    else
        echo "${indent}├── [$type] $name"
    fi
}

# Function to process each entry
process_entry() {
    local entry="$1"
    local indent="$2"
    local is_last="$3"

    local name="${entry##*/}"
    local fullpath="$entry"
    local type=""

    if should_exclude "$name"; then
        return
    fi

    if [ -d "$fullpath" ]; then
        type="Directory"
    else
        type="File"
    fi

    print_entry "$name" "$type" "$indent" "$is_last"

    if [ -d "$fullpath" ]; then
        if [ $is_last -eq 1 ]; then
            generate_tree "$fullpath" "${indent}    "
        else
            generate_tree "$fullpath" "${indent}│   "
        fi
    fi
}

# Function to format the file tree
generate_tree() {
    local path="$1"
    local indent="$2"
    local entries=($(get_entries "$path"))

    local count=${#entries[@]}

    for entry in "${entries[@]}"; do
        local is_last=0
        if [ $count -eq 1 ]; then
            is_last=1
        fi
        process_entry "$entry" "$indent" "$is_last"
        count=$((count - 1))
    done
}

# Get the current time
current_time=$(date +"%H-%M-%S")

# Determine output file location
if [ -z "$output_location" ]; then
    output_location="file_tree_${current_time}.md"
fi

# Write to file_tree
{
    echo "# File Tree"
    echo
    echo "Path to Directory: $(pwd)"
    echo
    echo "\`\`\`zsh"
    generate_tree "." ""
    echo "\`\`\`"
} >"$output_location"

echo "File tree has been written to $output_location"
