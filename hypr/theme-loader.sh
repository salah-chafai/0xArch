#!/bin/zsh

THEME_FILE="$HOME/.config/themes/global-theme.jsonc"

if [[ ! -f "$THEME_FILE" ]]; then
    echo "Error: Theme file not found at $THEME_FILE" >&2
    exit 1
fi

get_color() {
    local color_name="$1"
    jq -r ".colors${color_name}" "$THEME_FILE" 2>/dev/null || echo ""
}

hyprland_col_active_border_color1=$(get_color ".hyprland.col_active_border.color1")
hyprland_col_active_border_color2=$(get_color ".hyprland.col_active_border.color2")
hyprland_col_inactive_border=$(get_color ".hyprland.col_inactive_border")
hyprland_col_window_background=$(get_color ".hyprland.col_window_background")
hyprland_col_window_border=$(get_color ".hyprland.col_window_border")
hyprland_col_window_border_gradient=$(get_color ".hyprland.col_window_border_gradient")

HYPRLAND_THEME_FILE="/tmp/hyprland-theme.conf"

cat > "$HYPRLAND_THEME_FILE" <<EOF
\$active_border_color1=${hyprland_col_active_border_color1}
\$active_border_color2=${hyprland_col_active_border_color2}
\$inactive_border_color=${hyprland_col_inactive_border}
\$window_background_color=${hyprland_col_window_background}
\$window_border_color=${hyprland_col_window_border}
\$window_border_gradient_color=${hyprland_col_window_border_gradient}
EOF

echo "Hyprland theme generated at ${HYPRLAND_THEME_FILE}"
hyprctl reload
