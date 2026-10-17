class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "4.5.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v4.5.0/mods_4.5.0_Darwin_arm64.tar.gz"
      sha256 "1b7a783dcfbe8fb4f1e61e0b3a434196f8342947773959e61c6e1b58f0885e7c"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v4.5.0/mods_4.5.0_Darwin_x86_64.tar.gz"
      sha256 "662fb5f38fc055a46b543a2d4014ee587da54f630772e28cfd0d27d4b79ca95a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v4.5.0/mods_4.5.0_Linux_arm64.tar.gz"
      sha256 "11911922aec3f0514cc4fe3b1ee2267220a93554f481ac281bfd52f0464c4234"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v4.5.0/mods_4.5.0_Linux_x86_64.tar.gz"
      sha256 "17f995d6d3f4e3ca7f428945f74500c5281c182439615060e200e9dcc283c81a"
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
