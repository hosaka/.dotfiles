#!/usr/bin/env pwsh

param(
    [Alias('Y')]
    [switch]$Yes,

    [Alias('H')]
    [switch]$Help,

    [Parameter(Position = 0)]
    [string]$Command,

    [Parameter(Position = 1)]
    [string]$Subcommand
)

$ScoopUrl = "https://get.scoop.sh"

$ProfileDir = Split-Path $Profile.CurrentUserAllHosts -Parent
. (Join-Path $ProfileDir "functions.ps1")

function Usage {
    Write-Host "Dotfiles bootstrap installer for PowerShell"
    Write-Host ""
    Write-Host "Usage: dotstrap [OPTIONS] <COMMAND>"
    Write-Host ""
    Write-Host "Commands:"
    Write-Host "  all         Install everything"
    Write-Host "  scoop       Command line installer for Windows"
    Write-Host "  mise        Development tools and environment management"
    Write-Host "  link <LINK> Create symlinks for tool configuration folders, where"
    Write-Host "              LINK is [all|neovim|lazygit]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Y, -Yes    Answer yes to all prompts"
    Write-Host "  -H, -Help   Print this help message and quit"
    Write-Host ""
}

function Ask($Message) {
    if ($Yes) { return $true }

    $response = Read-Host "$BOLD$BLUE>$NO_COLOR $Message (y/N)"
    switch -Regex ($response) {
        '^(y|yes)$' { return $true }
        default { return $false }
    }
}

function Remind {
    Info 'reload the shell to update the paths (. $Profile.CurrentUserAllHosts)'
}

function Get-Scoop {
    if (-not (Ask "this will install scoop, continue?")) {
        return
    }
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri $ScoopUrl | Invoke-Expression
}

function Get-Mise {
    if (-not (Ask "this will install mise, continue?")) {
        return
    }
    if (Has "mise") {
        Info "mise is already installed: $($(Get-Command mise.exe).Source)"
    }
    else {
        if (-not (Has "scoop")) {
            if (Ask "mise can be installed with scoop instead, install scoop first?") {
                Get-Scoop
            }
            else {
                # Fetch directly
                return
            }
        }
        scoop install mise
    }
}

function All {
    Get-Scoop
    Get-Mise
    Remind
}

function Symlink($Tool, $Source, $Target) {
    if (Test-Path $Target){
        Warn "not creating a symlink because $Target already exists"
        return
    }
    Info "symlinking $Tool ($Source $GREEN->$NO_COLOR $Target)"
    New-Item -Path $Target -ItemType SymbolicLink -Value $Source
}

function Link-Neovim {
    Symlink "neovim" "$env:UserProfile\.config\nvim" "$env:LocalAppData\nvim"
}
function Link-Lazygit {
    Symlink "lazygit" "$env:UserProfile\.config\lazygit" "$env:LocalAppData\lazygit"
}

function Link-All {
    Link-Neovim
    Link-Lazygit
}

if ($Help) {
    Usage
    exit 0
}

if (-not $Command) {
    Usage
    exit 1
}

if ($Yes) {
    Info "skipping confirmation prompts (-Yes)"
}

switch ($Command) {
    "all" { All }
    "scoop" { Get-Scoop; }
    "mise" { Get-Mise; Remind }
    "link" {
        switch ($Subcommand) {
            'all' { Link-All }
            'neovim' { Link-Neovim }
            'lazygit' { Link-Lazygit }
            default {
                Error "invalid link command -- '$Subcommand'"
            }
        }
    }
    default {
        Error "invalid command -- '$Command'"
    }
}
