class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "5.1.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v5.1.0/mods_5.1.0_Darwin_arm64.tar.gz"
      sha256 "9e611314bcff92f3624f002295231b182e2ab36cb4941931823c168583eea49f"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v5.1.0/mods_5.1.0_Darwin_x86_64.tar.gz"
      sha256 "947f4f493461c88f27c53da08382845c21c440610f875aa20765a136e1dee3a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v5.1.0/mods_5.1.0_Linux_arm64.tar.gz"
      sha256 "f13efc6cc47a759040d93e23e1a495aeb4e7d9d01489360d3c8c2f721d6f60f7"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v5.1.0/mods_5.1.0_Linux_x86_64.tar.gz"
      sha256 "d4cafc8497e5461b1af5938f2c3e9070ab9e39a14138943484759257a7f07595"
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
