#!/usr/bin/env bash

git_dir="$(cd `tmux display-message -p -F "#{pane_current_path}"`)"
git_user="$(git config --get --local user.name)"
git_email="$(git config --get --local user.email)"

if [ ! -z ${git_email} ]; then
  printf %s "[${git_user}#${git_email}]"
fi

unset branch_name
unset git_user
unset git_email
