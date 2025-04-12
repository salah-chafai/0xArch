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

waybar_color1=$(get_color ".waybar.color1")
waybar_color2=$(get_color ".waybar.color2")
waybar_color3=$(get_color ".waybar.color3")
waybar_color4=$(get_color ".waybar.color4")
waybar_hover=$(get_color ".waybar.hover")
waybar_text=$(get_color ".waybar.text")
waybar_accent=$(get_color ".waybar.accent")
waybar_warning=$(get_color ".waybar.warning")
waybar_battery=$(get_color ".waybar.battery")
waybar_audio=$(get_color ".waybar.audio")
waybar_network=$(get_color ".waybar.network")
waybar_bluetooth=$(get_color ".waybar.bluetooth")
waybar_backlight=$(get_color ".waybar.backlight")
waybar_workspace_active=$(get_color ".waybar.workspace_active")
waybar_workspace_urgent=$(get_color ".waybar.workspace_urgent")

WAYBAR_THEME_FILE="/tmp/waybar-theme.css"

cat > "$WAYBAR_THEME_FILE" <<EOF
@define-color color-1 ${waybar_color1};
@define-color color-2 ${waybar_color2};
@define-color color-3 ${waybar_color3};
@define-color color-4 ${waybar_color4};
@define-color hover ${waybar_hover};
@define-color text ${waybar_text};
@define-color accent ${waybar_accent};
@define-color warning ${waybar_warning};
@define-color battery ${waybar_battery};
@define-color audio ${waybar_audio};
@define-color network ${waybar_network};
@define-color bluetooth ${waybar_bluetooth};
@define-color backlight ${waybar_backlight};
@define-color workspace-active ${waybar_workspace_active};
@define-color workspace-urgent ${waybar_workspace_urgent};
EOF

echo "Waybar theme generated at ${WAYBAR_THEME_FILE}"
