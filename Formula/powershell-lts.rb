# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellLts < Formula
  desc "Formula to install PowerShell Long Term Stable Channel"
  homepage "https://github.com/powershell/powershell"
  # We do not specify `version "..."` as 'brew audit' will complain - see https://github.com/Homebrew/legacy-homebrew/issues/32540
  url "https://github.com/PowerShell/PowerShell/releases/download/v7.0.7/powershell-7.0.7-osx-x64.tar.gz"
  version "7.0.7"
  # must be lower-case
  sha256 "6ae06612a00978fcf93b2df335c55359c3491fde00cb6cfba0c5743e9729475d"
  version_scheme 1
  bottle :unneeded

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on macos: :high_sierra

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh" => "pwsh-lts"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh-lts`. If not, the full path to the executable is:
        #{bin}/pwsh-lts

      Other application files were installed at :
        #{libexec}

      If you also have the Cask installed, you need to run the following to make the formula your default install:
        brew link --overwrite powershell

      If you would like to make PowerShell LTS your default shell, run
        sudo echo '#{bin}/pwsh-lts' >> /etc/shells
        chsh -s #{bin}/pwsh-lts
    EOS
  end

  test do
    assert_equal "7.0.7",
                 shell_output("#{bin}/pwsh-lts -c '$psversiontable.psversion.tostring()'").strip
  end
end
