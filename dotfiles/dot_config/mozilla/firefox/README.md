# Firefox Config

## user.js

The `user.js` is a custom configuration that tweaks Firefox to be more private and secure. I have used [Betterfox](https://github.com/yokoffing/Betterfox) as a starting template. This file should be placed in the root of a Firefox profile (after installing Firefox, start it at least once to create a new profile folder in `~/.config/mozilla/firefox/`):

```bash
cd ~/.config/mozilla/firefox
cp user.js 85jgroeo.default-default/
```

## policies.json

Not all configuration entries can be controlled by `user.js`. For additional privacy focused tweaks (disabling telemetry, disabling Pocket, preventing update checks and configuring custom search engines) a system-wide `policies.json` can be used. This file needs to be placed in a system directory. When applied correctly you will see a `Your browser is being managed by your organization` message when opening `about:preferences`. In addition, you can see which policies are applied by visiting `about:policies`. Ideally, you would want to install these policies along with the `user.js` as soon as Firefox has been installed:

```bash
cd ~/.config/mozilla/firefox/policies.json /etc/firefox/policies/
```
