#!/bin/zsh

THEME_FILE="$HOME/.config/themes/global-theme.jsonc"

if [[ ! -f "$THEME_FILE" ]]; then
    echo "Error: Theme file not found at $THEME_FILE" >&2
    exit 1
fi

get_color() {
    local color_name="$1"
    jq -r ".colors.waybar.${color_name} // empty" "$THEME_FILE"
}

WAYBAR_THEME_FILE="/tmp/waybar-theme.css"

cat > "$WAYBAR_THEME_FILE" <<EOF
@define-color background $(get_color background);
@define-color foreground $(get_color foreground);
@define-color backlight $(get_color backlight);
@define-color battery $(get_color battery);
@define-color audio $(get_color audio);
@define-color mic $(get_color mic);
@define-color clock $(get_color clock);
@define-color network $(get_color wifi);
@define-color bluetooth $(get_color bluetooth);
@define-color power $(get_color power);
@define-color cpu $(get_color cpu);
@define-color ram $(get_color ram);
@define-color gpu $(get_color gpu);
@define-color workspace-active $(get_color workspace_active);
@define-color workspace-urgent $(get_color workspace_urgent);
@define-color hover $(get_color hover);
@define-color text $(get_color text);
@define-color text-hover $(get_color text_hover);
@define-color warning $(get_color warning || echo "#f38ba8");
@define-color light $(get_color light || echo "#313244");
EOF

echo "Waybar theme generated at ${WAYBAR_THEME_FILE}"
