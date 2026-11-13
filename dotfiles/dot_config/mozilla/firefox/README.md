# Firefox Config

## user.js

The `user.js` is a custom configuration that tweaks Firefox to be more private and secure. I have used [Betterfox](https://github.com/yokoffing/Betterfox) as a starting template. This file should be placed in the root of a Firefox profile (after installing Firefox, start it at least once to create a new profile folder in `~/.config/mozilla/firefox/`):

```bash
cd ~/.config/mozilla/firefox
cp user.js 85jgroeo.default-default/
```

## policies.json

Not all configuration entries can be controlled by `user.js`. For additional privacy focused tweaks (disabling telemetry, disabling Pocket, preventing update checks and configuring custom search engines) a system-wide `policies.json` can be used. This file needs to be placed in a system directory. When applied correctly you will see a `Your browser is being managed by your organization` message when opening `about:preferences`. In addition, you can see which policies are applied by visiting `about:policies`.

The policies live in the system source ([system/etc/firefox/policies/policies.json](../../../../system/etc/firefox/policies/policies.json)) and are installed with the rest of the system files:

```bash
sdot apply /etc/firefox/policies/policies.json
```
