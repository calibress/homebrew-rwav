class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server"
  homepage "https://github.com/calibress/rwav-mcp-bridge"
  url "https://github.com/calibress/rwav-mcp-bridge/releases/download/v0.1.9/rwav-bridge-mcp-v0.1.9.tar.gz"
  sha256 "3b0cc9f3a32d935e162843797e9fda28e4c11e5742dfa745e96c02a729e4250e"
  license :cannot_represent

  depends_on "node"

  def install
    libexec.install "build/rwav-bridge-mcp.cjs", "bin/rwav-bridge-mcp.js", "LICENSE", "README.md", "package.json"
    bin.write_exec_script libexec/"rwav-bridge-mcp.js"
  end

  def post_install
    system "[31m#{bin}/rwav-bridge-mcp[0m", "--setup"
  end

  test do
    output = shell_output("#{bin}/rwav-bridge-mcp --version")
    assert_match "0.1.9", output
  end
end
