# Build + link-check exactly like GitHub Actions, to catch a broken build
# or a broken link locally before pushing.
# Run from the repo root in PowerShell: .\scripts\check.ps1
#
# Calls Git Bash's bash.exe by its full path on purpose: a bare "bash" in
# PowerShell can resolve to Windows' WSL launcher stub instead (if WSL has no
# distro installed, that fails with "execvpe(/bin/bash) failed").

$gitBash = "C:\Program Files\Git\bin\bash.exe"
if (-not (Test-Path $gitBash)) {
    Write-Error "Git Bash not found at $gitBash - install Git for Windows, or edit this script's path."
    exit 1
}

# --login: sources Git Bash's profile, which builds its usual PATH
# (dirname, sh, etc). Without it, bash inherits PowerShell's plain Windows
# PATH and is missing basic Unix tools.
$repoRoot = Split-Path -Parent $PSScriptRoot
& $gitBash --login "$repoRoot/scripts/check.sh"
exit $LASTEXITCODE
