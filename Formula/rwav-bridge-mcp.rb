class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server"
  homepage "https://github.com/calibress/rwav-mcp-bridge"
  url "https://github.com/calibress/rwav-mcp-bridge/releases/download/v0.2.1/rwav-bridge-mcp-v0.2.1.tar.gz"
  sha256 "ca0179b0fc8e37a2ba63f8630382b41e0977d9f9c1a042d845aa7c43b005a1bf"
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
    assert_match "0.2.1", output
  end
end
