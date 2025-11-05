class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server (Model Context Protocol)"
  homepage "https://rwav-bridge.co.uk/mcp/"
  url "https://github.com/calibress/rwav-mcp-bridge/releases/download/v0.1.6/rwav-mcp-server-0.1.5.tgz"
  sha256 "4bf373473d01b01bb83b3a273d83f44adb505321d01c7032428cf041e536cefe"
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
