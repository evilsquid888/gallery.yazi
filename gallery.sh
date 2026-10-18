#!/bin/sh
# Launcher for gallery.yazi. POSIX sh so it runs on Linux and macOS alike.

set -eu
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH:-}"

plugin_dir="$(cd "$(dirname "$0")" && pwd -P)"
python_script="${plugin_dir}/gallery.py"
state_dir="${TMPDIR:-/tmp}"
selection_state_file="${state_dir}/gallery-yazi-selection.txt"
result_state_file="${state_dir}/gallery-yazi-selection-result.txt"
focus_state_file="${state_dir}/gallery-yazi-focus.txt"

if [ ! -f "$python_script" ]; then
	printf 'Gallery launcher is missing: %s\n' "$python_script" >&2
	exit 1
fi

hovered_path="${1:-}"

exec /usr/bin/env python3 "$python_script" "$hovered_path" "$selection_state_file" "$result_state_file" "$focus_state_file"
