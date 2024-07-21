
# File Tree Script

This script generates a file tree of the current directory and outputs it to a markdown file. The script is designed for `zsh` but works on `bash` as well.

## Installation

### Clone the Repository

Clone the repository using the following command:

   ```sh
   git clone https://github.com/EastTexasElectronics/FileTreeGenerator.git
   ```

### Change Directory

Change directory to the cloned repository:

   ```sh
   cd FileTreeGenerator
   ```

### Make the Script Executable

Make the script executable by running:

```sh
chmod +x ftg.sh
```

### Add an Alias to your `~/.zshrc` or `~/.bashrc` file

To make the script easier to use, add an alias to your shell configuration file.

Feel free to add any flags or options you want to the alias such as `-i` for interactive mode.

```sh
alias ftg="~/path/to/FileTreeGenerator/ftg.sh"
```

You will need to replace `~/path/to/FileTreeGenerator` with the actual path to the cloned repository.

### Source your Shell Configuration

After adding the alias, reload your shell configuration with the following command:

```sh
source ~/.zshrc    # For zsh
source ~/.bashrc   # For bash
```

## Usage

Run the script using the alias:

```sh
ftg [options]
```

### Command Line Options

| Option             | Alias | Description                                                                       |
|--------------------|-------|-----------------------------------------------------------------------------------|
| `-e`, `--exclude`  |       | Exclude directories or files (comma-separated). Example: `-e .git,node_modules`    |
| `-o`, `--output`   |       | Specify a different output location for the generated file tree.                   |
| `-i`, `--interactive` |   | Interactive mode for excluding directories or files.                               |
| `-h`, `--help`     |       | Show help message and exit.                                                       |
| `-v`, `--version`  |       | Show version information and exit.                                                |

### Example Commands

- Exclude specific directories (please note that the `.git` and `node_modules` directories are already excluded by default):

  ```sh
  ftg -e [package1],[directory],[.dotfile],[file]
  ```

- Specify a different output location:

  ```sh
  ftg -o /path/to/output/file_tree.md
  ```

- Interactive mode for excluding directories or files:

  ```sh
  ftg -i
  ```

- Show help message:

  ```sh
  ftg -h
  ```

- Show version information:

  ```sh
  ftg -v
  ```

## Customization

### Adding or Removing Exclude Patterns

To add or remove exclude patterns, modify the `exclude_patterns` array in the script:

```sh
exclude_patterns+=(node_modules .next .vscode .idea .git .DS_Store)
```

Add or remove entries as needed. For example, to exclude a directory named `logs`, add `logs` to the array:

```sh
exclude_patterns+=(logs)
```

### Changing the Output File Location

By default, the script generates the output file in the current directory with a timestamped name. To change the default output location, use the `-o` option when running the script:

```sh
ftg -o /desired/path/to/output/file_tree.md
```

Alternatively, you can modify the script directly by setting the `output_location` variable to your desired path:

```sh
output_location="/desired/path/to/output/file_tree.md"
```

## Example Output

Default output while using the base create t3 app template:

```sh
├── [File] 
├── [File] .env
├── [File] .env.example
├── [File] .eslintrc.cjs
├── [File] .gitignore
├── [File] README.md
├── [File] bun.lockb
├── [File] file_tree_21-54-30.md
├── [File] next-env.d.ts
├── [File] next.config.js
├── [File] package.json
├── [File] postcss.config.cjs
├── [File] prettier.config.js
├── [Directory] prisma
│   └── [File] 
├── [Directory] public
│   └── [File] 
├── [Directory] src
│   ├── [File] 
│   ├── [Directory] app
│   │   ├── [File] 
│   │   ├── [Directory] _components
│   │   │   └── [File] 
│   │   ├── [Directory] api
│   │   │   ├── [File] 
│   │   │   └── [Directory] auth
│   │   │       └── [File] 
│   │   └── [File] layout.tsx
│   ├── [File] env.js
│   ├── [Directory] server
│   │   ├── [File] 
│   │   ├── [Directory] api
│   │   │   ├── [File] 
│   │   │   ├── [File] root.ts
│   │   │   └── [Directory] routers
│   │   │       └── [File] 
│   │   └── [File] auth.ts
│   └── [Directory] styles
│       └── [File] 
└── [File] tailwind.config.ts
```

## Author

This script was created by [easttexaselectronics](https://github.com/easttexaselectronics). Contributions and feedback are welcome!

## License

This project is licensed under the GNU Affero General Public License v3.0. For more information, see the [LICENSE](LICENSE) file.
