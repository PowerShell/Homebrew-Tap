# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class Powershell < Formula
  desc "Formula to install PowerShell"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.3/powershell-7.2.3-osx-arm64.tar.gz"
  @x64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.3/powershell-7.2.3-osx-x64.tar.gz"
  @arm64sha256 = "0066e0157e44ac990cf8c65ff854a5d12c06fb71d4f56fbf1803c4ad1c967a79"
  @x64sha256 = "c51bc719a2b146558ae79471496ded9dab576d7b742598b40920c7829c3ea3ec"

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

  version "7.2.3"
  version_scheme 1

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on macos: :high_sierra

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh`. If not, the full path to the executable is:
        #{bin}/pwsh

      Other application files were installed at :
        #{libexec}

      If you also have the Cask installed, you need to run the following to make the formula your default install:
        brew link --overwrite powershell

      If you would like to make PowerShell your default shell, run
        sudo sh -c "echo '#{bin}/pwsh'>> /etc/shells"
        chsh -s #{bin}/pwsh
    EOS
  end

  test do
    assert_equal "7.2.3",
                 shell_output("#{bin}/pwsh -c '$psversiontable.psversion.tostring()'").strip
  end
end
