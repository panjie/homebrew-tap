class Mods < Formula
  desc "An AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  url "https://github.com/panjie/mods/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "4791193123410aa90ce2b7323b4fc47d011fae3a764db8a9e0b44249f3e5d3a3"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.Version=v#{version}"
    system "go", "build", "-trimpath", "-ldflags=#{ldflags}", "-o", bin/"mods", "."

    generate_completions_from_executable(bin/"mods", "completion")
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/mods --version")
  end
end
