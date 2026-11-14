# privilege escalation prefix (noop when already root)
sudo := ```
  if [ "$(id -u)" -eq 0 ]; then :
  elif command -v sudo >/dev/null 2>&1; then echo sudo
  elif command -v doas >/dev/null 2>&1 && [ -f /etc/doas.conf ]; then echo doas
  else echo "su root -c '\"\$0\" \"\$@\"'"
  fi
```
