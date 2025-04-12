#!/bin/zsh

THEME_FILE="/home/x-0r/.config/themes/global-theme.jsonc"

if [[ ! -f "$THEME_FILE" ]]; then
    echo "Error: Theme file not found at $THEME_FILE"
    exit 1
fi

get_color() {
    local color_name="$1"
    jq -r ".colors${color_name}" "$THEME_FILE"
}

if [[ $EUID -eq 0 ]]; then
    zsh_os_bg=$(get_color ".zsh_root.os_bg")
    zsh_os_fg=$(get_color ".zsh_root.os_fg")
    zsh_os_to_user_bg=$(get_color ".zsh_root.os_to_user_bg")
    zsh_user_bg=$(get_color ".zsh_root.user_bg")
    zsh_user_fg=$(get_color ".zsh_root.user_fg")
    zsh_user_to_dir_bg=$(get_color ".zsh_root.user_to_dir_bg")
    zsh_error_color=$(get_color ".zsh_root.error")
else
    zsh_os_bg=$(get_color ".zsh_user.os_bg")
    zsh_os_fg=$(get_color ".zsh_user.os_fg")
    zsh_os_to_user_bg=$(get_color ".zsh_user.os_to_user_bg")
    zsh_user_bg=$(get_color ".zsh_user.user_bg")
    zsh_user_fg=$(get_color ".zsh_user.user_fg")
    zsh_user_to_dir_bg=$(get_color ".zsh_user.user_to_dir_bg")
    zsh_error_color=$(get_color ".zsh_user.error")
fi

zsh_link_fg=$(get_color ".zsh_common.link_fg")
zsh_dir_bg=$(get_color ".zsh_common.dir_bg")
zsh_dir_fg=$(get_color ".zsh_common.dir_fg")
zsh_dir_to_git_bg=$(get_color ".zsh_common.dir_to_git_bg")
zsh_git_bg=$(get_color ".zsh_common.git_bg")
zsh_git_fg=$(get_color ".zsh_common.git_fg")
zsh_python_bg=$(get_color ".zsh_common.python_bg")
zsh_python_fg=$(get_color ".zsh_common.python_fg")
zsh_autosuggest_fg=$(get_color ".zsh_common.autosuggest_fg")

zsh_bright_green=$(get_color ".zsh_common.syntax.bright_green")
zsh_greenish_yellow=$(get_color ".zsh_common.syntax.greenish_yellow")
zsh_bright_teal=$(get_color ".zsh_common.syntax.bright_teal")
