# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.
param (
    [switch] $Audit,
    [switch] $Fix
)

$formulas = Get-ChildItem $PSScriptRoot/Formula/*.rb

if ($Audit.IsPresent) {
    foreach ($file in $formulas) {
        Write-Verbose "auditing $($file.Name) ..." -Verbose
        $extraParams = @()
        if ($Fix.IsPresent) {
            $extraParams += '--fix'
        }
        brew audit --strict --online --display-filename --display-cop-names $extraParams $file.FullName
    }
}
