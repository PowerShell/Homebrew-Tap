# Homebrew tap for PowerShell Products

> [!WARNING]
> **This tap is deprecated and no longer maintained.**
>
> PowerShell is now available directly from the official, signed and notarized
> `.pkg` installers published by the PowerShell project, as well as from
> [Homebrew Core](https://formulae.brew.sh/formula/powershell). Please migrate to
> one of the [recommended installation methods](#recommended-installation) below.
> The `powershell/tap/*` formulas in this repository no longer work.

## Recommended installation

### Official `.pkg` installer (recommended)

The PowerShell project publishes macOS `.pkg` installers for both Apple silicon
(`arm64`) and Intel (`x64`) Macs. Beginning with the May 2026 releases, these
packages are **notarized and signed by Microsoft**, so you can download and open
them directly without bypassing Gatekeeper.

1. Download the `.pkg` for your processor architecture from the
   [PowerShell releases page](https://github.com/PowerShell/PowerShell/releases).
2. Double-click the downloaded package and follow the installer prompts.

To update, download and install the newer package. For full instructions —
including the Gatekeeper workarounds needed for releases prior to May 2026 — see
[Install PowerShell on macOS](https://learn.microsoft.com/powershell/scripting/install/install-powershell-on-macos).

### Homebrew (community formula)

PowerShell is also published to [Homebrew Core](https://formulae.brew.sh/formula/powershell),
so you no longer need this tap. Install it with:

```sh
brew install powershell
```

If you previously installed PowerShell using the Homebrew cask, you must first
uninstall the cask before you can successfully install using the Homebrew
formula:

```sh
# Uninstall the PowerShell cask instance
brew uninstall --cask powershell
# Uninstall the PowerShell Preview cask instance
brew uninstall --cask powershell-preview
```

If you receive the message *"Warning: PowerShell is already installed, it's just
not linked."*, run:

```sh
brew link powershell
```

To update PowerShell to the latest release:

```sh
brew update
brew upgrade powershell
```

> [!NOTE]
> The brew formula is maintained and supported by the Homebrew community. It
> builds PowerShell from source code rather than installing a package built by
> Microsoft. See
> [Alternate ways to install PowerShell](https://learn.microsoft.com/powershell/scripting/install/alternate-install-methods#install-on-macos-using-homebrew)
> for details.

## Requirements

1. You must be running a version of macOS supported by PowerShell.
1. See [Homebrew requirements](https://docs.brew.sh/Installation#macos-requirements).

Issues with PowerShell itself can be reported at
[PowerShell/PowerShell](https://github.com/PowerShell/PowerShell/issues/new/choose).

## Code of Conduct

Please see our [Code of Conduct](.github/CODE_OF_CONDUCT.md) before participating in this project.

## Security Policy

For any security issues, please see our [Security Policy](.github/SECURITY.md).
