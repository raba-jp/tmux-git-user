#!/usr/bin/env bash

source_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${source_path}/helpers.sh"

get_separator() {
	local separator_option="@git_user_separator"
	local default_separator_char="#"
	echo "$(get_tmux_option "${separator_option}" "${default_separator_char}")"
}

get_env_value() {
	local key="$1"
	local target="$2"
	local path="$(tmux display-message -p -F '#{pane_current_path}')"
	echo "$(cd ${path} && git config --get ${target} ${key})"
}

get_config_value() {
	key="$1"
	local local_value=`get_env_value ${key} "--local"`
	local global_value=`get_env_value ${key} "--global"`
	[[ -n ${local_value} ]] && echo ${local_value} || echo ${global_value}
}

name=`get_config_value "user.name"`
email=`get_config_value "user.email"`
separator=`get_separator`
[[ -n ${name} || -n ${email} ]] && echo "${name}${separator}${email}"

unset source_path
unset name
unset email
unset separator
