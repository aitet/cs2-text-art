#!/bin/sh
cs="steamapps/common/Counter-Strike Global Offensive/game/csgo/cfg/art"

if [ -d "$HOME/.steam" ]; then
	path="$HOME/.steaml/root/$cs"
else
	path="${XDG_DATA_HOME:-$HOME/.local/share}/Steam/$cs"
fi

mkdir -p "$path" || exit 1
[ -f "$path/1.cfg" ] && rm "$path"/*.cfg

if [ -z "$1" ] || [ "$1" = "-" ] ; then
	text="$(cat /dev/stdin)"
	[ -z "$text" ] && exit 255
else
    text=$(figlet -k "$@" | sed 's/ /./g')
fi

printf '%s\n' "$text" | while read -r line; do
	i=$((i+1))
	file="$path/$i.cfg"
	echo "say $line" > "$file" &
	echo "bind p exec art/$((i+1))" >> "$file" &
	echo "bind o exec art/1" >> "$file" &
done
