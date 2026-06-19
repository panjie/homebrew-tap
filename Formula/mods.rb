class Mods < Formula
  desc "AI for the command-line, built for pipelines"
  homepage "https://github.com/panjie/mods"
  url "https://github.com/panjie/mods/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "be3706a9bf8bf4bc571ee730201b2606456c0a8e5a79b0e492d11af988f73f4a"
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
