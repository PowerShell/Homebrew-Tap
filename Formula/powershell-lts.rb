# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellLts < Formula
  desc "Formula to install PowerShell Long Term Stable Channel"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/powershell-7.2.8-osx-arm64.tar.gz"
  @x64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.8/powershell-7.2.8-osx-x64.tar.gz"
  @arm64sha256 = "3b3d917c6afeff86f567e10c740a2b34e1ad51f48872f61c340e9cbe007d387f"
  @x64sha256 = "4c73410e2181bb794b2d9ee519bf64f5f25e9aa7c480d141fc194c28b75dd87d"

  # We do not specify `version "..."` as 'brew audit' will complain - see https://github.com/Homebrew/legacy-homebrew/issues/32540
  if Hardware::CPU.intel?
    url @x64url
    # must be lower-case
    sha256 @x64sha256
  else
    url @arm64url
    # must be lower-case
    sha256 @arm64sha256
  end

  version "7.2.8"
  version_scheme 1

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
    assert_equal "7.2.8",
                 shell_output("#{bin}/pwsh-lts -c '$psversiontable.psversion.tostring()'").strip
  end
end
