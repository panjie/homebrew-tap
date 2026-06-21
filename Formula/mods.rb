class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v2.0.0/mods_2.0.0_Darwin_arm64.tar.gz"
      sha256 "8e836bc47693fb82028c079efee2d55833350d0a0d4009f83f17a75af39d4258"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v2.0.0/mods_2.0.0_Darwin_x86_64.tar.gz"
      sha256 "e606e21f3eca6d509f23eeb9744848305e4e58c2cf269e22f49c528d76e4c496"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v2.0.0/mods_2.0.0_Linux_arm64.tar.gz"
      sha256 "7e4458dd4f92e237f94a9e55a95eb85ce6a65b154acdcde3db2a8fc4e0141c27"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v2.0.0/mods_2.0.0_Linux_x86_64.tar.gz"
      sha256 "3f3eb9ca65cc9e557c8f20716c709d1b352ec29d7d76f0ea9a99567c474edff9"
    end
  end

  def install
    if build.head?
      ldflags = "-s -w -X main.Version=v#{version}"
      system "go", "build", "-trimpath", "-ldflags=#{ldflags}", "-o", bin/"mods", "."
    else
      bin.install "mods"
    end
    generate_completions_from_executable(bin/"mods", "completion")
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/mods --version")
  end
end
