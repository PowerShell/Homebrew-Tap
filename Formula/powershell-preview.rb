# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.
class PowershellPreview < Formula
  desc "PowerShell Preview"
  homepage "https://github.com/powershell/powershell"
  # We do not specify `version "..."` as 'brew audit' will complain - see https://github.com/Homebrew/legacy-homebrew/issues/32540
  url "https://github.com/PowerShell/PowerShell/releases/download/v7.1.0-preview.3/powershell-7.1.0-preview.3-osx-x64.tar.gz"
  version "7.1.0-preview.3"
  # must be lower-case
  sha256 "14d790998c4ac4ab9c756b0d5b0a88218585f4a8f0aeb4c4ac0c265021522e08"
  version_scheme 1
  bottle :unneeded

  # .NET Core 3.1 requires High Sierra - https://docs.microsoft.com/en-us/dotnet/core/install/dependencies?pivots=os-macos&tabs=netcore31
  depends_on :macos => :high_sierra

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

      If you would like to make PowerShell you shell, run
        sudo echo '#{bin}/pwsh-preview' >> /etc/shells
        chsh -s #{bin}/pwsh-preview
    EOS
  end

  test do
    assert_equal "7.1.0-preview.3",
      shell_output("#{bin}/pwsh-preview -c '$psversiontable.psversion.tostring()'").strip
  end
end
