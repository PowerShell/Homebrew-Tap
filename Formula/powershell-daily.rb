# typed: false
# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.

# frozen_string_literal: true

# Doc for the class.
# Class to implement Brew Formula to install PowerShell
class PowershellDaily < Formula
  desc "Formula to install PowerShell Daily"
  homepage "https://github.com/powershell/powershell"

  @arm64url = "https://pscoretestdata.blob.core.windows.net/v7-3-0-daily20220224-2/powershell-7.3.0-daily20220224.2-osx-arm64.tar.gz"
  @x64url = "https://pscoretestdata.blob.core.windows.net/v7-3-0-daily20220224-2/powershell-7.3.0-daily20220224.2-osx-x64.tar.gz"
  @arm64sha256 = "05c507c1e5638ece115b49fab63c59857cafa650f0fbd34fe098a88d386343a2"
  @x64sha256 = "6aefb90400f09c048a7553dfda0c976ac907852121cc3d3d2aa88f7256c1182f"

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

  version "7.3.0-daily20220224.2"
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
    assert_equal "7.3.0-daily20220224.2",
                 shell_output("#{bin}/pwsh-daily -c '$psversiontable.psversion.tostring()'").strip
  end
end
