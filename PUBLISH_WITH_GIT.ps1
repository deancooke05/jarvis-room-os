<#
Publishes this already-sanitised starter folder to an empty GitHub repository.

Example:
  powershell -ExecutionPolicy Bypass -File .\PUBLISH_WITH_GIT.ps1 `
    -RepositoryUrl "https://github.com/deancooke05/jarvis-room-os.git"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RepositoryUrl
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git is not installed or not on PATH. Install GitHub Desktop or Git for Windows, then rerun this script."
}

Push-Location $Root
try {
    python scripts\verify_public_repo.py
    if ($LASTEXITCODE -ne 0) {
        throw "Public-repo verification did not pass. Review the listed files before publishing."
    }

    if (-not (Test-Path (Join-Path $Root ".git"))) {
        git init
        git branch -M main
    }

    git add .
    git status --short
    $answer = Read-Host "The files above will be committed. Type PUBLISH to continue"
    if ($answer -ne "PUBLISH") {
        throw "Publish cancelled. Nothing was pushed."
    }

    git commit -m "Initial public portfolio release"
    git remote remove origin 2>$null
    git remote add origin $RepositoryUrl
    git push -u origin main
}
finally {
    Pop-Location
}
