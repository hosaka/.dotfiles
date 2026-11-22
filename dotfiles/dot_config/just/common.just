# the module's name, or the repository's at the top level, messages start with it
tag := if module_file() == justfile() { file_name(justfile_directory()) } else { file_stem(module_file()) }

# privilege escalation prefix (noop when already root)
sudo := ```
  if [ "$(id -u)" -eq 0 ]; then :
  elif command -v sudo >/dev/null 2>&1; then echo sudo
  elif command -v doas >/dev/null 2>&1 && [ -f /etc/doas.conf ]; then echo doas
  else echo "su root -c '\"\$0\" \"\$@\"'"
  fi
```

[private]
@onpath tool:
    echo 'using {{ require(tool) }}' > /dev/null
