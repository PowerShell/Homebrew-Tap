# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellPreview < Formula
  desc "Formula to install PowerShell Preview"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.3/powershell-7.6.0-preview.3-osx-arm64.tar.gz"
  @x64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.6.0-preview.3/powershell-7.6.0-preview.3-osx-x64.tar.gz"
  @arm64sha256 = "93779106A33A61BA9BADC3B7C20859D28F005B46CB27342828A8E45123417316"
  @x64sha256 = "CCC08C24422B8050AD216F55FD21141AB2241CC10192D47BB92EC5F350B81398"

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

  version "7.6.0-preview.3"
  version_scheme 1

  livecheck do
    url :head
  end

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on macos: :high_sierra

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh" => "pwsh-preview"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh-preview`. If not, the full path to the executable is:
        #{bin}/pwsh-preview

      Other application files were installed at:
        #{libexec}

      If you also have the Cask installed, you need to run the following to make the formula your default install:
        brew link --overwrite powershell-preview

      If you would like to make PowerShell Preview your default shell, run
        sudo echo '#{bin}/pwsh-preview' >> /etc/shells
        chsh -s #{bin}/pwsh-preview
    EOS
  end

  test do
    assert_equal "7.6.0-preview.3",
                 shell_output("#{bin}/pwsh-preview -c '$psversiontable.psversion.tostring()'").strip
  end
end
