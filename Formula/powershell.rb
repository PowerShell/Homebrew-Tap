# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.
class Powershell < Formula
  desc "PowerShell"
  homepage "https://github.com/powershell/powershell"
  # We do not specify `version "..."` as 'brew audit' will complain - see https://github.com/Homebrew/legacy-homebrew/issues/32540
  url "https://github.com/PowerShell/PowerShell/releases/download/v7.0.2/powershell-7.0.2-osx-x64.tar.gz"
  version "7.0.2"
  # must be lower-case
  sha256 "ca0b8d6893236f8a45d1f000fc482cdeec7054dbef8fb178dde6f8b3e15b8511"
  version_scheme 1
  bottle :unneeded

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on :macos => :high_sierra

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh`. If not, the full path to the executable is:
        #{bin}/pwsh

      Other application files were installed at:
        #{libexec}

      If you also have the Cask installed, you need to run the following to make the formula your default install:
        brew link --overwrite powershell

      If you would like to make PowerShell you shell, run
        sudo echo '#{bin}/pwsh' >> /etc/shells
        chsh -s #{bin}/pwsh
    EOS
  end

  test do
    assert_equal "7.0.2",
      shell_output("#{bin}/pwsh -c '$psversiontable.psversion.tostring()'").strip
  end
end
