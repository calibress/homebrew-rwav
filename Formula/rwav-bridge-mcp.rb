class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server (Model Context Protocol)"
  homepage "https://rwav-bridge.co.uk/mcp/"
  url "https://github.com/calibress/rwav-mcp-server/releases/download/v0.1.8/calibress-rwav-bridge-mcp-0.1.8.tgz"
  sha256 "2d9c4966e184815f335394cc1f9ac9d365bda70a21c5e430569d9d868f6ea7a2"
  license "Proprietary"

  revision 1

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    out = shell_output("#{bin}/rwav-bridge-mcp --help", 0)
    assert_match "RWAV Bridge MCP", out
  end
end
