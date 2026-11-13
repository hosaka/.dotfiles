# System files

Files outside of `$HOME` (mostly `/etc`) that deviate from a default Void install. This is a separate chezmoi source state with `/` as the destination, so a plain `chezmoi apply` never touches it (`.chezmoiroot` points at `dotfiles/`).

Use the `sdot` alias (fish and bash), it runs chezmoi as root via doas:

```bash
sdot diff                           # what would change in /etc
sdot apply                          # apply everything
sdot apply /etc/greetd/config.toml  # apply a single file
```

Root keeps its own chezmoi state in `/root/.config/chezmoi`, separate from the dotfiles state. Edit files here as your own user, never with `sdot add` or `sdot edit` (they would leave root owned files in the repo).

There are no templates in here on purpose: there is no data to render them with (root has no chezmoi config). Everything is static and safe to apply on any of my Void machines, e.g. `modprobe.d/nvidia.conf` does nothing without the nvidia driver.

These files are also baked into the [vast-mklive](https://code.hosaka.cc/hosaka/vast-mklive) ISO, which also reads the repositories and ignored packages from `etc/xbps.d/`.

| Path | Why |
| --- | --- |
| `/etc/cron.weekly/fstrim` | weekly TRIM, run by `snooze-weekly` |
| `/etc/default/useradd` | default shell for new users is fish (void-installer does not ask) |
| `/etc/doas.conf` | doas instead of sudo (sudo is ignored) |
| `/etc/firefox/policies/policies.json` | telemetry off, custom search engines, see `dot_config/mozilla/firefox/README.md` |
| `/etc/greetd/config.toml` | noctalia greeter |
| `/etc/modprobe.d/nvidia.conf` | KMS for the proprietary driver, needed by niri |
| `/etc/pipewire/pipewire.conf.d/` | start wireplumber and pipewire-pulse with pipewire |
| `/etc/turnstile/turnstiled.conf` | runit backend for user services (`~/.config/service`), rundir is managed by elogind |
| `/etc/xbps.d/` | own mirror, vast-packages repo, ignored packages |
