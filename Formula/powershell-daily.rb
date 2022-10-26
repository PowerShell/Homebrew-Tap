# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellDaily < Formula
  desc "Formula to install PowerShell Daily"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://pscoretestdata.blob.core.windows.net/v7-3-0-daily20221026-1/powershell-7.3.0-daily20221026.1-osx-arm64.tar.gz"
  @x64url = "https://pscoretestdata.blob.core.windows.net/v7-3-0-daily20221026-1/powershell-7.3.0-daily20221026.1-osx-x64.tar.gz"
  @arm64sha256 = "caa53caec17a0bc7f940a7c820afdd8c8fba9dcf8c7022fbfbda19252b8818dc"
  @x64sha256 = "b8beca0195ee67f516337b18e7d141e30ade5a5b9a0a2a9790a79e23d08a115f"

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

  version "7.3.0-daily20221026.1"
  version_scheme 1

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on macos: :high_sierra

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"pwsh"
    bin.install_symlink libexec/"pwsh" => "pwsh-daily"
  end

  def caveats
    <<~EOS
      The executable should already be on PATH so run with `pwsh-daily`. If not, the full path to the executable is:
        #{bin}/pwsh-daily

      Other application files were installed at :
        #{libexec}

      If you would like to make PowerShell Daily your default shell, run
        sudo echo '#{bin}/pwsh-daily' >> /etc/shells
        chsh -s #{bin}/pwsh-daily
    EOS
  end

  test do
    assert_equal "7.3.0-daily20221026.1",
                 shell_output("#{bin}/pwsh-daily -c '$psversiontable.psversion.tostring()'").strip
  end
end
