class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server"
  homepage "https://github.com/calibress/rwav-mcp-bridge"
  url "https://github.com/calibress/rwav-mcp-bridge/releases/download/v0.2.13/rwav-bridge-mcp-v0.2.13.tar.gz"
  sha256 "14d67c0a582aefca008f2fb836a0a1a6f763742ef58ace0e8c0c8a978422e99a"
  license :cannot_represent
  revision 1

  depends_on "node"
  depends_on "sqlite"

  def install
    libexec.install "build/rwav-bridge-mcp.cjs", "bin/rwav-bridge-mcp.js", "bin/rwav-bridge-mcp-doctor.js", "bin/rwav-bridge-mcp-setup.js", "LICENSE", "README.md", "package.json"
    # Ensure wrappers execute via Node explicitly (works even if libexec JS lacks +x)
    (bin/"rwav-bridge-mcp").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp.js" "$@"
    SH
    (bin/"rwav-bridge-mcp-doctor").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp-doctor.js" "$@"
    SH
    (bin/"rwav-bridge-mcp-setup").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp-setup.js" "$@"
    SH
    chmod 0755, bin/"rwav-bridge-mcp", bin/"rwav-bridge-mcp-doctor", bin/"rwav-bridge-mcp-setup"
  end

  def post_install
    system "#{bin}/rwav-bridge-mcp", "--setup"
  end

  test do
    output = shell_output("#{bin}/rwav-bridge-mcp --version")
    assert_match version.to_s, output
  end
end
