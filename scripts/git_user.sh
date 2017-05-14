#!/usr/bin/env bash

current_path="$(tmux display-message -p -F '#{pane_current_path}')"

global_name="$(cd ${current_path} && git config --get --global user.name)"
global_email="$(cd ${current_path} && git config --get --global user.email)"

local_name="$(cd ${current_path} && git config --get --local user.name)"
local_email="$(cd ${current_path} && git config --get --local user.email)"

if [ -z ${local_name} ]; then
  name="${global_name}"
else
  name="${local_name}"
fi

if [ -z ${local_email} ]; then
  email="${global_email}"
else
  email="${local_email}"
fi

echo "${name}#${email}"

unset current_path
unset global_name
unset global_email
unset local_name
unset local_email
unset name
unset email
