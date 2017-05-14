#!/usr/bin/env bash

current_pane_path="$(tmux display-message -p -F '#{pane_current_path}')"

separator_option="@git_user_separator"
default_separator_char="#"

git_user_interpolation_string="\#{git_user}"

get_user_data() {
	local separator="$(get_tmux_option "${separator_option}" "${default_separator_char}")"

	local global_name="$(cd ${current_pane_path} && git config --get --global user.name)"
	local global_email="$(cd ${current_pane_path} && git config --get --global user.email)"
	local local_name="$(cd ${current_pane_path} && git config --get --local user.name)"
	local local_email="$(cd ${current_pane_path} && git config --get --local user.email)"

	[ -n ${local_name} ] && local name="${local_name}" || local name="${global_name}"

	[ -n ${local_email} ] && local email="${local_email}" || local email="${global_email}"

	[[ -n ${name} || -n ${email} ]] && echo "${name}${separator}${email}"
}

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value="$(tmux show-option -gqv "$option")"
	[[ -n "$option_value" ]] && echo "$option_value" || echo "$default_value"
}

do_interpolation() {
	local string="$1"
	local git_user=get_user_data
	local interpolated="${string/$git_user_interpolation_string/$git_user}"
	printf %s "$interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
