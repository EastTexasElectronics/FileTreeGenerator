# File Tree Generator (ftg)

File Tree Generator (`ftg`) is a command-line tool that generates a tree view of the directory structure. It supports excluding specific files or directories and provides an interactive mode for selecting exclusions.

## Features

- Generate a tree view of the directory structure.
- Exclude specific files or directories.
- Interactive mode for selecting exclusions.
- Specify a custom output location for the generated tree.
- Display version information.

## Installation

### Using Homebrew

1. **Install `ftg`**:

   ```sh
   brew install ftg
   ```

### Using Git

1. **Clone the repository**:

   ```sh
   git clone https://github.com/EastTexasElectronics/FileTreeGenerator
   ```

2. **Navigate to the repository directory**:

   ```sh
   cd file-tree-generator
   ```

3. **Make the script executable**:

   ```sh
   chmod +x ftg
   ```

4. **Move the script to a directory in your PATH** (e.g., `/usr/local/bin`):

   ```sh
   sudo mv ftg /usr/local/bin/
   ```

## Usage

The `ftg` script can be used with various options to customize its behavior.

```sh
ftg [-e pattern1,pattern2,...] [-o output_location] [-i] [-h] [-v]
```

### Options

- `-e, --exclude`: Exclude directories or files (comma-separated) (e.g., `-e .git,node_modules`).
- `-o, --output`: Specify a different output location.
- `-i, --interactive`: Interactive mode for excluding directories or files.
- `-h, --help`: Show help message and exit.
- `-v, --version`: Show version information and exit.

### Examples

1. **Generate a tree view of the current directory**:

   ```sh
   ftg
   ```

2. **Exclude `.git` and `node_modules` directories**:

   ```sh
   ftg -e .git,node_modules
   ```

3. **Specify a custom output location**:

   ```sh
   ftg -o /path/to/output/file_tree.md
   ```

4. **Interactive mode for selecting exclusions**:

   ```sh
   ftg -i
   ```

5. **Show help message**:

   ```sh
   ftg -h
   ```

6. **Show version information**:

   ```sh
   ftg -v
   ```

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

Thank you for using File Tree Generator! If you have any questions or feedback, please feel free to open an issue or submit a pull request.
