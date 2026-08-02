class Mods < Formula
  desc "AI agent for your terminal"
  homepage "https://github.com/panjie/mods"
  version "4.0.0"
  license "MIT"
  head "https://github.com/panjie/mods.git", branch: "main" do
    depends_on "go" => :build
  end

  on_macos do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v4.0.0/mods_4.0.0_Darwin_arm64.tar.gz"
      sha256 "e4be38cab14ad76cf15d286ba8862ee592bbfb7dd5d26d690a5fcdd1e1ba7a51"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v4.0.0/mods_4.0.0_Darwin_x86_64.tar.gz"
      sha256 "a5e8014fa4e9fae7ba4556588f0ae7bfc57dbcc7af31a3b9cb3b7b492b57a973"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/panjie/mods/releases/download/v4.0.0/mods_4.0.0_Linux_arm64.tar.gz"
      sha256 "85e83aaaf3f7c2b52aaec0a88d2db6e21ee89feacbce0c58ec79a49d3e68a2bb"
    end
    on_intel do
      url "https://github.com/panjie/mods/releases/download/v4.0.0/mods_4.0.0_Linux_x86_64.tar.gz"
      sha256 "14232d0ca8c24ed231f1c2022e6f8bfde6d6d742a5e4bec1179d84be684c98c1"
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
