#!/usr/bin/env bash

source_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "${source_path}/scripts/helpers.sh"

git_user_interpolation_string="\#{git_user}"
git_user="#(${source_path}/scripts/git_user.sh)"

do_interpolation() {
	local string="$1"
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
