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

wofi_window_bg=$(get_color ".wofi.window_bg")
wofi_border_color=$(get_color ".wofi.border_color")
wofi_input_bg=$(get_color ".wofi.input_bg")
wofi_input_border=$(get_color ".wofi.input_border")
wofi_input_text=$(get_color ".wofi.input_text")
wofi_entry_bg=$(get_color ".wofi.entry_bg")
wofi_entry_hover=$(get_color ".wofi.entry_hover")
wofi_entry_selected=$(get_color ".wofi.entry_selected")
wofi_entry_text=$(get_color ".wofi.entry_text")
wofi_entry_selected_text=$(get_color ".wofi.entry_selected_text")

WOFI_THEME_FILE="/tmp/wofi-theme.css"

cat > "$WOFI_THEME_FILE" <<EOF
@define-color wofi_window_bg ${wofi_window_bg};
@define-color wofi_border_color ${wofi_border_color};
@define-color wofi_input_bg ${wofi_input_bg};
@define-color wofi_input_border ${wofi_input_border};
@define-color wofi_input_text ${wofi_input_text};
@define-color wofi_entry_bg ${wofi_entry_bg};
@define-color wofi_entry_hover ${wofi_entry_hover};
@define-color wofi_entry_selected ${wofi_entry_selected};
@define-color wofi_entry_text ${wofi_entry_text};
@define-color wofi_entry_selected_text ${wofi_entry_selected_text};
EOF

echo "Wofi theme variables generated at ${WOFI_THEME_FILE}"
