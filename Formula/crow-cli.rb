class CrowCli < Formula
  desc "Reverse agents and persistent tmux-like terminal sessions"
  homepage "https://github.com/startedourmission/crow-cli"
  url "https://github.com/startedourmission/crow-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "887be7ca4159d163a6c629196185c1ae0e015bf6624894ef58051c948f3f8c0c"
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
