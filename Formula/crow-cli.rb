class CrowCli < Formula
  desc "Reverse agents and persistent tmux-like terminal sessions"
  homepage "https://github.com/startedourmission/crow-cli"
  url "https://github.com/startedourmission/crow-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f974afb20ec2d2da1e0f7a31c4732b7d8e49bfdf8eaedbb495a19dc11441b913"
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
