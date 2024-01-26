# if not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# # if running bash
# if [ -n "$BASH_VERSION" ]; then
#   # include .bashrc if it exists
#   if [ -f "$HOME/.bashrc" ]; then
#     . "$HOME/.bashrc"
#   fi
# fi
#
# # set PATH so it includes user's private bin if it exists
# if [ -d "$HOME/.local/bin" ]; then
#   PATH="$HOME/.local/bin:$PATH"
# fi
#
# # load hostname specific profiles
# [ -e ".config/$(hostname).profile" ] && . ".config/$(hostname).profile"
