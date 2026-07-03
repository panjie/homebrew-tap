class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "3.0.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v3.0.0/mods_3.0.0_Darwin_arm64.tar.gz"
      sha256 "9ddf7534bedefa269f62956df9660942861cf39141f023a28d6b31a51ad4e84b"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v3.0.0/mods_3.0.0_Darwin_x86_64.tar.gz"
      sha256 "1c4ef241015c62d6cc2a4c11ca23fb16348bd33721e81bb59d1c081a3d63d943"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v3.0.0/mods_3.0.0_Linux_arm64.tar.gz"
      sha256 "9a286946140922956f18919fe191ecd87b2acabc54ec21329b4c5aa2a6c0f74d"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v3.0.0/mods_3.0.0_Linux_x86_64.tar.gz"
      sha256 "5852a5270357562076ce2045b448cc6168035b1761d65db34f2da0d969e6a5ff"
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
