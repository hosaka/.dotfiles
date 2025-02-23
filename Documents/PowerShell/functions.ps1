# ANSI escape sequences
$BOLD      = "`e[1m"
$GREY      = "`e[90m"
$UNDERLINE = "`e[4m"
$RED       = "`e[31m"
$GREEN     = "`e[32m"
$YELLOW    = "`e[33m"
$BLUE      = "`e[34m"
$MAGENTA   = "`e[35m"
$NO_COLOR  = "`e[0m"

function Info {
    param([Parameter(ValueFromRemainingArguments=$true)]$Message)
    Write-Output "$BOLD$GREY> $NO_COLOR$($Message -join ' ')"
}

function Warn {
    param([Parameter(ValueFromRemainingArguments=$true)]$Message)
    Write-Output "$YELLOW! $($Message -join ' ')$NO_COLOR"
}

function Error {
    param([Parameter(ValueFromRemainingArguments=$true)]$Message)
    Write-Output "$($RED)x $($Message -join ' ')$NO_COLOR"
}

# run a command, discarding all output
function Hush {
    & @args > $null 2>&1
}

function Has {
    param([string]$Command)
    return (Get-Command $Command -ErrorAction SilentlyContinue) -ne $null
}

function Need {
    param([string]$Command)
    if (-not (Has $Command)) {
        Error "need '$Command' (command not found)"
    }
}

function Ensure {
    try {
        & @args | Out-Null
    } catch {
        Error "command failed: $($args -join ' ')"
    }
}

# add to path if not already present
function OnPath {
    param([string]$Dir)
    if (Test-Path $Dir -PathType Container) {
        $paths = $env:PATH -split ';'
        if ($paths -notcontains $Dir) {
            $env:PATH = "$Dir;$env:PATH"
        }
    }
}

# source if exists
function Include {
    param([string]$File)
    if (Test-Path $File) {
        . $File
    }
}

