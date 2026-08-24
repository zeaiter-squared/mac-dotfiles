# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/ZEAITER.ZEAITER/.docker/bin"
# End of Docker Desktop section.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
