class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "4.1.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v4.1.0/mods_4.1.0_Darwin_arm64.tar.gz"
      sha256 "7679dc6bcb11eb8ade3d60e0ddb2d47b69d59dc1a55f6d5f67ae1d10b477ed2c"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v4.1.0/mods_4.1.0_Darwin_x86_64.tar.gz"
      sha256 "70a519736ca0ab8fda1287df04459d87ba580247d27c47d3ad6947464ecc3037"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v4.1.0/mods_4.1.0_Linux_arm64.tar.gz"
      sha256 "740c35b6e20039624deedb92623f377b2afb591b4ea5520fb37702568fd2261b"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v4.1.0/mods_4.1.0_Linux_x86_64.tar.gz"
      sha256 "85d0aca15dfca1304110b0aee0d531f19aee259fadb821b47f20f49dd1ef61c6"
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
