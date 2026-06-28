class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "2.5.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v2.5.0/mods_2.5.0_Darwin_arm64.tar.gz"
      sha256 "b17d868b52d16de8d572000f1f82f8f1e6e61639a8235960a393812d70efda78"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v2.5.0/mods_2.5.0_Darwin_x86_64.tar.gz"
      sha256 "3bffb08f525fe5a788394d8f1ca90e95454fb9144423432905e57e2fd900932d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v2.5.0/mods_2.5.0_Linux_arm64.tar.gz"
      sha256 "f94b23d6ccd42315198f6b440975a64d18a983da5154de8864836a165fd70774"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v2.5.0/mods_2.5.0_Linux_x86_64.tar.gz"
      sha256 "c4582a63f33db64945c4bc7b7d1bac614090274fcc93e1e5e8a6b691bb0fee71"
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
