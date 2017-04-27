#!/usr/bin/env bash

git_dir="$(cd `tmux display-message -p -F "#{pane_current_path}"`)"
git_user="$(git config --get user.name)"
git_email="$(git config --get user.email)"

if [ ! -z ${git_user} ]; then
  printf %s "[${git_user}#${git_email}]"
fi

unset branch_name
unset git_user
unset git_email
