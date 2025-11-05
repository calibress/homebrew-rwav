class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server (Model Context Protocol)"
  homepage "https://rwav-bridge.co.uk/mcp/"
  url "https://rwav-bridge.co.uk/wp-content/uploads/2025/11/rwav-bridge-mcp-0.1.8.zip"
  sha256 "ca3d3e8027f6863a7009d31cb9ace42740db44ed80dfa85201be209795336fbb"
  license "Proprietary"

  revision 1

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def post_install
    system "#{bin}/rwav-bridge-mcp", "--setup"
  end

  test do
    out = shell_output("#{bin}/rwav-bridge-mcp --help", 0)
    assert_match "RWAV Bridge MCP", out
  end
end
