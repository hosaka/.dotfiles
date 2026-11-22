# Manage YubiKeys for encrypting and decrypting dotfiles.

import '../common.just'

alias s := status

[doc('list recipes (default)')]
[no-cd]
@help:
    just --justfile ~/.justfile --list dot key --no-aliases

[doc('show recipients, plugged in YubiKeys and encrypted files (alias `s`)')]
[no-cd]
status: (onpath 'jq') (onpath 'git') (onpath 'age') (onpath 'age-plugin-yubikey')
    #!/usr/bin/env bash
    set -euo pipefail
    {{ logger }}

    IFS=$'\t' read -r age_yubikey recipients < <(chezmoi dump-config --format json | jq -r '[.age.command, .age.recipientsFile] | @tsv')
    plugged=$("$age_yubikey" --list)
    label() { printf 'YubiKey %s slot %s: %s (PIN %s, touch %s)' "$1" "$2" "$3" "${4,,}" "${5,,}"; }

    header "recipients.txt (${recipients/#$HOME/\~})"
    while read -r recipient; do
      line=$(awk -F'\t' -v r="$recipient" '$2 == r' <<<"$plugged")
      if [ -n "$line" ]; then
        IFS=$'\t' read -r _ _ serial slot name pin touch <<<"$line"
        printf '  %s  %s\n' "${recipient:0:24}…" "$(label "$serial" "$slot" "$name" "$pin" "$touch")"
      else
        printf '  %s  %s\n' "${recipient:0:24}…" "${grey}not plugged in${reset}"
      fi
    done < <(grep '^age1' "$recipients")

    if grep -q '^no' <<<"$plugged"; then
      header "plugged in, not in recipients.txt (add one with \`just dot key new\`)"
      while IFS=$'\t' read -r _ recipient serial slot name pin touch; do
        printf '  %s  %s\n' "${recipient:0:24}…" "$(label "$serial" "$slot" "$name" "$pin" "$touch")"
      done < <(grep '^no' <<<"$plugged")
    fi

    readable=false
    [ "$("$age_yubikey" --check)" != ok ] || readable=true

    header "encrypted files"
    src=$(chezmoi source-path)
    while read -r file; do
      target=$(chezmoi target-path "$src/$file")
      if [ ! -e "$target" ]; then
        state="${grey}not deployed${reset}"
      elif ! $readable; then
        state=deployed
      elif cmp -s "$target" <(chezmoi decrypt "$src/$file" </dev/null); then
        state="deployed, in sync"
      elif [ "$target" -nt "$src/$file" ]; then
        state="${yellow}changed since, \`just dot encrypt\` updates the source${reset}"
      else
        state="${yellow}newer in the source, \`just dot decrypt\` deploys it${reset}"
      fi
      printf '  %s  %s\n' "${target/#$HOME/\~}" "$state"
    done < <(git -C "$src" ls-files --cached --others --exclude-standard -- '*.age')

    if $readable; then
      success "a YubiKey from recipients.txt is plugged in, the encrypted files can be decrypted"
    else
      warning "no YubiKey from recipients.txt is readable (plugged in, pcscd running), chezmoi skips the encrypted files that aren't deployed yet"
    fi

[doc('add a plugged in YubiKey to recipients.txt and re-encrypt')]
[no-cd]
[no-exit-message]
new: (onpath 'jq') (onpath 'git') (onpath 'age') (onpath 'age-plugin-yubikey')
    #!/usr/bin/env bash
    set -euo pipefail
    {{ logger }}

    IFS=$'\t' read -r age_yubikey recipients < <(chezmoi dump-config --format json | jq -r '[.age.command, .age.recipientsFile] | @tsv')
    plugged=$("$age_yubikey" --list)

    [ -n "$plugged" ] || error "no YubiKey with an age identity is plugged in, age-plugin-yubikey --generate sets one up"
    grep -q '^yes' <<<"$plugged" || error "plug in a YubiKey from recipients.txt as well, re-encrypting needs one to decrypt"

    mapfile -t unlisted < <(grep '^no' <<<"$plugged" || true)
    if [ ${#unlisted[@]} -eq 0 ]; then
      info "every plugged in YubiKey is already in recipients.txt"
      yono "re-encrypt the encrypted files to recipients.txt as it is?" || exit 1
      just --justfile ~/.justfile dot key _reencrypt
      exit 0
    fi

    for i in "${!unlisted[@]}"; do
      IFS=$'\t' read -r _ _ serial slot name pin touch <<<"${unlisted[i]}"
      printf '%2d) YubiKey %s slot %s: %s (PIN %s, touch %s)\n' $((i + 1)) "$serial" "$slot" "$name" "${pin,,}" "${touch,,}"
    done
    printf '%s ' "${bold}${yellow}[$tag]${reset} add which one to recipients.txt and re-encrypt the encrypted files? [1-${#unlisted[@]}, enter cancels]" >&2
    read -r n || n=
    if ! [[ $n =~ ^[0-9]+$ ]] || ((n < 1 || n > ${#unlisted[@]})); then exit 1; fi

    IFS=$'\t' read -r _ recipient serial slot name _ <<<"${unlisted[n - 1]}"
    before=$(<"$recipients")
    echo "$recipient" >>"$recipients"
    if ! just --justfile ~/.justfile dot key _reencrypt; then
      printf '%s\n' "$before" >"$recipients"
      error "recipients.txt is back as it was"
    fi
    success "added YubiKey $serial slot $slot ($name) to ${recipients/#$HOME/\~}"

[doc('remove a YubiKey from recipients.txt and re-encrypt')]
[no-cd]
[no-exit-message]
remove: (onpath 'jq') (onpath 'git') (onpath 'age') (onpath 'age-plugin-yubikey')
    #!/usr/bin/env bash
    set -euo pipefail
    {{ logger }}

    IFS=$'\t' read -r age_yubikey recipients < <(chezmoi dump-config --format json | jq -r '[.age.command, .age.recipientsFile] | @tsv')
    plugged=$("$age_yubikey" --list)
    mapfile -t listed < <(grep '^age1' "$recipients")

    [ ${#listed[@]} -gt 1 ] || error "recipients.txt only has one YubiKey, add another one first (just dot key new)"
    grep -q '^yes' <<<"$plugged" || error "plug in a YubiKey from recipients.txt, re-encrypting needs one to decrypt"

    for i in "${!listed[@]}"; do
      line=$(awk -F'\t' -v r="${listed[i]}" '$2 == r' <<<"$plugged")
      if [ -n "$line" ]; then
        IFS=$'\t' read -r _ _ serial slot name pin touch <<<"$line"
        printf '%2d) YubiKey %s slot %s: %s (PIN %s, touch %s)\n' $((i + 1)) "$serial" "$slot" "$name" "${pin,,}" "${touch,,}"
      else
        printf '%2d) %s (not plugged in)\n' $((i + 1)) "${listed[i]}"
      fi
    done
    printf '%s ' "${bold}${yellow}[$tag]${reset} remove which one from recipients.txt and re-encrypt the encrypted files? [1-${#listed[@]}, enter cancels]" >&2
    read -r n || n=
    if ! [[ $n =~ ^[0-9]+$ ]] || ((n < 1 || n > ${#listed[@]})); then exit 1; fi

    before=$(<"$recipients")
    grep -vxF "${listed[n - 1]}" <<<"$before" >"$recipients"
    if ! just --justfile ~/.justfile dot key _reencrypt; then
      printf '%s\n' "$before" >"$recipients"
      error "recipients.txt is back as it was"
    fi
    success "removed ${listed[n - 1]:0:24}… from ${recipients/#$HOME/\~}"

# re-encrypt every encrypted file in the source to recipients.txt, from chezmoi decrypt
# straight into chezmoi encrypt. All of them are re-encrypted and checked before any is
# replaced, a failure leaves them as they were.
[no-cd]
[no-exit-message]
_reencrypt: (onpath 'git') (onpath 'age') (onpath 'age-plugin-yubikey')
    #!/usr/bin/env bash
    set -euo pipefail
    {{ logger }}

    src=$(chezmoi source-path)
    mapfile -t files < <(git -C "$src" ls-files --cached --others --exclude-standard -- '*.age')
    [ ${#files[@]} -gt 0 ] || { info "no encrypted files to re-encrypt"; exit 0; }
    tmps=()
    trap 'rm -f "${tmps[@]}"' EXIT

    for file in "${files[@]}"; do
      tmps+=("$src/$file.tmp")
      chezmoi decrypt "$src/$file" | chezmoi encrypt >"$src/$file.tmp" ||
        error "could not re-encrypt $file, nothing was changed"
      cmp -s <(chezmoi decrypt "$src/$file") <(chezmoi decrypt "$src/$file.tmp") ||
        error "re-encrypted $file does not decrypt to the same content, nothing was changed"
      # keep the modification time, `just dot encrypt` and `decrypt` compare it with the deployed file's
      touch -r "$src/$file" "$src/$file.tmp"
    done
    for file in "${files[@]}"; do
      mv "$src/$file.tmp" "$src/$file"
      success "re-encrypted $file"
    done
