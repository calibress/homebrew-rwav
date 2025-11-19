class RwavBridgeMcp < Formula
  desc "RWAV Bridge MCP server"
  homepage "https://github.com/calibress/rwav-mcp-bridge"
  url "https://github.com/calibress/rwav-mcp-bridge/releases/download/v0.2.20/rwav-bridge-mcp-v0.2.20.tar.gz"
  sha256 "c5b31f4013decac4c25b669e227ef98c7ca965d308deb31d2bb04cbb541f4d8c"
  license :cannot_represent

  depends_on "node"
  depends_on "sqlite"

  def install
    libexec.install "build/rwav-bridge-mcp.cjs", "build/rwav-bridge-mcp-http.cjs", "bin/rwav-bridge-mcp.js", "bin/rwav-bridge-mcp-http.js", "bin/rwav-bridge-mcp-doctor.js", "bin/rwav-bridge-mcp-setup.js", "dist/public/rwav-widget", "LICENSE", "README.md", "package.json"
    # Ensure wrappers execute via Node explicitly
    rm_f bin/"rwav-bridge-mcp"; rm_f bin/"rwav-bridge-mcp-http"; rm_f bin/"rwav-bridge-mcp-doctor"; rm_f bin/"rwav-bridge-mcp-setup"
    (bin/"rwav-bridge-mcp").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp.js" "$@"
    SH
    (bin/"rwav-bridge-mcp-http").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp-http.js" "$@"
    SH
    (bin/"rwav-bridge-mcp-doctor").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp-doctor.js" "$@"
    SH
    (bin/"rwav-bridge-mcp-setup").write <<~SH
      #!/bin/sh
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/rwav-bridge-mcp-setup.js" "$@"
    SH
    chmod 0755, [bin/"rwav-bridge-mcp", bin/"rwav-bridge-mcp-http", bin/"rwav-bridge-mcp-doctor", bin/"rwav-bridge-mcp-setup"]
  end

  def post_install
    system "#{bin}/rwav-bridge-mcp", "--setup"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/rwav-bridge-mcp --version")
    assert_match version.to_s, shell_output("#{bin}/rwav-bridge-mcp-http --version")
  end
end
