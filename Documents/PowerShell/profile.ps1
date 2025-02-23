$ProfileDir = Split-Path $Profile.CurrentUserAllHosts -Parent
$MachineProfile = Join-Path "$ProfileDir" "$($(hostname).ToLower()).profile.ps1"

. (Join-Path $ProfileDir "functions.ps1")
. (Join-Path $ProfileDir "aliases.ps1")

# load machine profiles
if (Test-Path $MachineProfile) {
  . $MachineProfile
}

