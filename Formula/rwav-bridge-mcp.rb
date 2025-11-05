class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server (Model Context Protocol)"
  homepage "https://rwav-bridge.co.uk/mcp/"
  url "https://github.com/calibress/rwav-mcp-server/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "Proprietary"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["
#{libexec}/bin/*"]
  end

  test do
    out = shell_output("
#{bin}/rwav-bridge-mcp --help", 0)
    assert_match "RWAV Bridge MCP", out
  end
end
