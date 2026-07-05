class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "3.2.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v3.2.0/mods_3.2.0_Darwin_arm64.tar.gz"
      sha256 "e48b9cf070f37321fe435c04dcfcc51086cae3ab10f16637d94afc0055495af5"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v3.2.0/mods_3.2.0_Darwin_x86_64.tar.gz"
      sha256 "b0e80918d899560df7632b5cea1437e3e05c2aaafe34835bf67879f054325572"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v3.2.0/mods_3.2.0_Linux_arm64.tar.gz"
      sha256 "2998e85bfe6443bf002a88918eda6392d5c6410486cd4434bfae8beaa4dc4942"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v3.2.0/mods_3.2.0_Linux_x86_64.tar.gz"
      sha256 "c5855659f1d58eb3f9b5058fe300ce702d7536184b8344242d58eb04498d929d"
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
