class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "5.2.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v5.2.0/mods_5.2.0_Darwin_arm64.tar.gz"
      sha256 "3330dd6dfdebca559fb0eb23e2d76a51dcd7719cdd511e7446feb3b42dfef23c"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v5.2.0/mods_5.2.0_Darwin_x86_64.tar.gz"
      sha256 "5f7d7065cfa5593649cc89636fa74dc88d08b77b32398617d377b54e9a54f388"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v5.2.0/mods_5.2.0_Linux_arm64.tar.gz"
      sha256 "8a089ad712a9624d179407231e8934ebec7f464083b317fa04f5b1b07acde22b"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v5.2.0/mods_5.2.0_Linux_x86_64.tar.gz"
      sha256 "e12ebb150cabdc01591c6f8072bde15b30161e39edb36bb87fe27767291f4660"
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
