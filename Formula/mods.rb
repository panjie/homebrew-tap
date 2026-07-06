class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "3.3.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v3.3.0/mods_3.3.0_Darwin_arm64.tar.gz"
      sha256 "a3ebf8cc30fdd8699a602499f52f150ae306cd491bcf2bcc07bebc4ab744e6f5"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v3.3.0/mods_3.3.0_Darwin_x86_64.tar.gz"
      sha256 "a2cc87593506aa2aa63ac26a34f9be2fec2c78496c4d7e2e6acc19bb5b9c3197"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v3.3.0/mods_3.3.0_Linux_arm64.tar.gz"
      sha256 "35366417d830af94c819eeaffa6f4cabade9f4ef0513fad3e7d1d00c68b86639"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v3.3.0/mods_3.3.0_Linux_x86_64.tar.gz"
      sha256 "bc3879d8adac783968a6e53da62310eaf8fcc92b356f4cc8fc3242ac5e9f4141"
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
