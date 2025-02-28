# navigation
function .. { Set-Location .. }
function ... { Set-Location "../.." }
function .... { Set-Location "../../.." }
function ..... { Set-Location "../../../.." }

# ls alternatives
if (Has "eza") {
    function ls  { & "eza"  @args }
    function la  { & "eza" -a @args }
    function ll  { & "eza" -l "--group-directories-first" @args }
    function lla { & "eza" -la "--group-directories-first" @args }
} elseif (Has "lsd") {
    function ls  { & "lsd"  @args }
    function la  { & "lsd" -a @args }
    function ll  { & "lsd" -lh "--group-directories-first" @args }
    function lla { & "lsd" -lah "--group-directories-first" @args }
}

if (Has "bat") {
    function help {
        param([Parameter(ValueFromRemainingArguments = $true)] $args)
        if ($args.Count -gt 0) {
            $command = $args[0]
            $otherArgs = if ($args.Count -gt 1) { $args[1..($args.Count-1)] } else { @() }
            & $command @otherArgs --help 2>&1 | & "bat" --plain --language=help
        }
    }
}

# highlight ripgrep output
if (Has "rg" -and Has "delta") {
    function rgd { & "rg" --json --context 2 @args | & "delta" }
}

# vimdiff alias using nvim
if (Has "nvim") {
    function vimdiff { & "nvim" -d @args }
}

# dotfiles management
function dot {
    param([Parameter(ValueFromRemainingArguments = $true)] $args)
    git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" @args
}
function dotadd {
    param([Parameter(ValueFromRemainingArguments = $true)] $args)
    dot add -f @args
}

# git
function gco { git checkout @args }
function gd  { git diff @args }
function gds { git diff --staged @args }
function gl  { git l @args }
function glg { git l --graph @args }
function gs  { git s @args }
function gst { git status @args }
function gsw { git switch @args }

if (Has "lazygit") {
    function gg    { & "lazygit" @args }
    function dotgg { & "lazygit" --git-dir="$HOME/.dotfiles" --work-tree="$HOME" @args }
}

# docker
function dimg { docker images @args }
function dpsa { docker ps -a @args }

if (Has "keychain") {
    function keychain { & "keychain" --quiet @args }
}

# vscodium
Set-Alias -Name code -Value codium
