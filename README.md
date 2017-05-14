# tmux-git-user

This plugin displays git user and git email above tmux status bar.

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'rabafea/tmux-git-user'

Hit `prefix + I` to fetch the plugin and source it. You should now be able to
use the plugin.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/rabafea/tmux-git-user ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/git-user.tmux

Reload TMUX environment with: `$ tmux source-file ~/.tmux.conf`. You should now
be able to use the plugin.

### License
[MIT](https://github.com/rabafea/tmux-git-user/blob/master/LICENSE)
