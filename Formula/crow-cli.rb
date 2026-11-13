class CrowCli < Formula
  desc "Reverse agents and persistent tmux-like terminal sessions"
  homepage "https://github.com/startedourmission/crow-cli"
  url "https://github.com/startedourmission/crow-cli/archive/refs/tags/v0.4.1.tar.gz"
  sha256 "9940b0654be394cd8c4a2c6c41e969953bc4370b28e8474cfaaa19ef57778a5c"
  license "MIT"
  head "https://github.com/startedourmission/crow-cli.git", branch: "main"

  uses_from_macos "python"

  def install
    system "make", "build"
    # The runtime copies crow, crowcli/ and src/ to servers, and finds the
    # daemon at build/crow-session next to the entry script.
    libexec.install "crow", "crowcli", "src", "build"
    bin.install_symlink libexec/"crow"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/crow --version")
    ENV["CROWCLI_HOME"] = testpath/"home"
    assert_match "crow-session", shell_output("#{bin}/crow doctor")
  end
end
