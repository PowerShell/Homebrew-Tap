# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellLts < Formula
  desc "Formula to install PowerShell Long Term Stable Channel"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.4.7/powershell-7.4.7-osx-arm64.tar.gz"
  @x64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.4.7/powershell-7.4.7-osx-x64.tar.gz"
  @arm64sha256 = "E673692D92D32378D9F4489E7919624A36D8915DA44A69E6125724250F52E2C6"
  @x64sha256 = "F5E88C4AF7C4B989762561567C80A43B8F549278D41C7C08ACEE7ABBAFF25637"

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

  version "7.4.7"
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
    assert_equal "7.4.7",
                 shell_output("#{bin}/pwsh-lts -c '$psversiontable.psversion.tostring()'").strip
  end
end
