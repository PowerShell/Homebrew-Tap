# Copyright (c) Microsoft Corporation.
# Licensed under the MIT license.
param (
    [switch] $Audit
)

$formulas = Get-ChildItem $PSScriptRoot/Formula/*.rb

if($Audit.IsPresent)
{
    foreach($file in $formulas)
    {
        Write-Verbose "auditing $($file.Name) ..." -Verbose
        brew audit --strict --online --display-filename --display-cop-names $file.FullName
    }
}
