# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellPreview < Formula
  desc "Formula to install PowerShell Preview"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.1/powershell-7.3.0-preview.1-osx-arm64.tar.gz"
  @x64url = "https://github.com/PowerShell/PowerShell/releases/download/v7.3.0-preview.1/powershell-7.3.0-preview.1-osx-x64.tar.gz"
  @arm64sha256 = "93358485326d5ac6a046d09d235d24b03de853c6e0d4f00b8b0058921f68151b"
  @x64sha256 = "5822ef852785760a0d8f75c7a69e7f77b02dce8e962f7de14793b834bfbe0c99"

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

  version "7.3.0-preview.1"
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
    assert_equal "7.3.0-preview.1",
                 shell_output("#{bin}/pwsh-preview -c '$psversiontable.psversion.tostring()'").strip
  end
end
