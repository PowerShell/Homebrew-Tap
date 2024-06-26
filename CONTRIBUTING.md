# Contributing

## Formula Updates

This repository will publish updates to the formula automatically.

Below are steps if you manually need to submit a PR to make changes.

To update the version, modify the url and sha256 in the formula. To get the new sha256 value, you can run `brew fetch --build-from-source ./Formula/powershell.rb`.

#### Local verification:
```
# Ensure you remove any current install of PowerShell
brew uninstall powershell
# Check you can install the new formula
brew install --verbose --build-from-source ./Formula/powershell.rb
# Run brew audit
brew audit --strict --online --display-filename --display-cop-names ./Formula/powershll.rb
# Run the tests in the formula
brew test ./Formula/powershell.rb
```

#### CI verification:
The repository has CI checks to validate the formula changes.\
Submit a PR to have the checks run.\
Ensure checks have passed before PRs are merged.

## Contributions

This project welcomes contributions and suggestions. Most contributions require you to
agree to a Contributor License Agreement (CLA) declaring that you have the right to,
and actually do, grant us the rights to use your contribution. For details, visit
https://cla.microsoft.com.

When you submit a pull request, a CLA-bot will automatically determine whether you need
to provide a CLA and decorate the PR appropriately (e.g., label, comment). Simply follow the
instructions provided by the bot. You will only need to do this once across all repositories using our CLA.
