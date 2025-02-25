$ProfileDir = Split-Path $Profile.CurrentUserAllHosts -Parent
$MachineProfile = (hostname).ToLower()

. (Join-Path $ProfileDir "functions.ps1")

# mise
if (Has "mise") {
  $env:MISE_ENV = "$MachineProfile-windows"
  mise activate pwsh | Out-String | Invoke-Expression
  # mise hook-env -s pwsh | Out-String | Invoke-Expression
}

# alias definitions (uses tools from cargo and mise)
. (Join-Path $ProfileDir "aliases.ps1")

# starship prompt
if (Has "starship") {
  Invoke-Expression (&starship init powershell)
}

# zoxide
if (Has "zoxide") {
  zoxide init powershell | Out-String | Invoke-Expression
}

# just
if (Has "just") {
  just --completions powershell | Out-String | Invoke-Expression
}

# delta
if (Has "delta") {
  $env:GIT_PAGER = "delta"
  $env:DELTA_FEATURES = "side-by-side line-numbers navigate"
  # todo: not sure how to add interactive.diffFilter = delta --color-only
}

# load machine profiles
$MachineProfileScript = Join-Path "$ProfileDir" "$MachineProfile.profile.ps1"
if (Test-Path $MachineProfileScript) {
  . $MachineProfileScript
}
