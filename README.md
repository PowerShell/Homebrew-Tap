# Homebrew tap for PowerShell Products

> [!WARNING]
> **This tap is deprecated and no longer maintained.**
>
> PowerShell is now available directly from
> [Homebrew Core](https://formulae.brew.sh/formula/powershell) as well as
> through the signed and notarized `.pkg` installers published by the PowerShell
> project. Please migrate to one of the [recommended installation
> methods](#recommended-installation) below. The `powershell/tap/*` formulas in
> this repository no longer work.

## Recommended installation

### Homebrew (community formula)

PowerShell is published to [Homebrew Core](https://formulae.brew.sh/formula/powershell),
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

### Signed and notarized `.pkg` installers (macOS)

Beginning with the May 2026 releases, the macOS `.pkg` packages published by the
PowerShell project are **notarized and signed by Microsoft**, making them a fully
supported macOS installation path. Download the package for your processor
architecture from the [PowerShell releases page](https://github.com/PowerShell/PowerShell/releases)
and open it to install.

For full instructions, including older-release Gatekeeper workarounds, see
[Install PowerShell on macOS](https://learn.microsoft.com/powershell/scripting/install/installing-powershell-on-macos).

## Requirements

1. You must be running a version of macOS supported by PowerShell.
1. See [Homebrew requirements](https://docs.brew.sh/Installation#macos-requirements).

Issues with PowerShell itself can be reported at
[PowerShell/PowerShell](https://github.com/PowerShell/PowerShell/issues/new/choose).

## Code of Conduct

Please see our [Code of Conduct](.github/CODE_OF_CONDUCT.md) before participating in this project.

## Security Policy

For any security issues, please see our [Security Policy](.github/SECURITY.md).
