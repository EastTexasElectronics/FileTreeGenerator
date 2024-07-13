class Ftg < Formula
  desc "File Tree Generator - Generates a tree view of the directory structure"
  homepage "https://github.com/yourusername/file-tree-generator"
  url "https://github.com/yourusername/file-tree-generator/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "your_generated_sha256_checksum"
  license "MIT"

  def install
    bin.install "ftg"
  end

  test do
    system "#{bin}/ftg", "--version"
  end
end
