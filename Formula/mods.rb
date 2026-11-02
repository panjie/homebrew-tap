class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "5.0.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v5.0.0/mods_5.0.0_Darwin_arm64.tar.gz"
      sha256 "969bf820f3bdf85c6fce9534603aa6c2cedefbdae6af17e2f5c6564a25b0095a"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v5.0.0/mods_5.0.0_Darwin_x86_64.tar.gz"
      sha256 "68d17ce3fe6b191bf67bf7db49766843e86fa073135009bf7723cf555a2e9537"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v5.0.0/mods_5.0.0_Linux_arm64.tar.gz"
      sha256 "6f40cc8a3c38746b75eb9c8fc5b5ce5b5d4d021df98d4c2dafec279687b83bde"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v5.0.0/mods_5.0.0_Linux_x86_64.tar.gz"
      sha256 "bf5c8ff01d96ea9a9cca6677f57db01c981a30df4815f494cc5b3bcef24c06a2"
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
