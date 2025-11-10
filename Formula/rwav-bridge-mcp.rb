class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server"
  homepage "https://github.com/calibress/rwav-mcp-bridge"
  url "https://github.com/calibress/rwav-mcp-bridge/releases/download/v0.2.9/rwav-bridge-mcp-v0.2.9.tar.gz"
  sha256 "89cce3c3a49525ead63499c49b7bcc8b5d6526257c875dbf0896e405627be965"
  license :cannot_represent

  depends_on "node"

  def install
    libexec.install "build/rwav-bridge-mcp.cjs", "bin/rwav-bridge-mcp.js", "bin/rwav-bridge-mcp-doctor.js", "bin/rwav-bridge-mcp-setup.js", "LICENSE", "README.md", "package.json"
    bin.write_exec_script libexec/"rwav-bridge-mcp.js"
    bin.write_exec_script libexec/"rwav-bridge-mcp-doctor.js"
    bin.write_exec_script libexec/"rwav-bridge-mcp-setup.js"
    bin.install_symlink bin/"rwav-bridge-mcp.js" => "rwav-bridge-mcp"
    bin.install_symlink bin/"rwav-bridge-mcp-doctor.js" => "rwav-bridge-mcp-doctor"
  end

  def post_install
    system "#{bin}/rwav-bridge-mcp", "--setup"
  end

  test do
    output = shell_output("#{bin}/rwav-bridge-mcp --version")
    assert_match "0.2.9", output
  end
end
