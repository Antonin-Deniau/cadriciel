
stdvar() {
	local filename=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')
	export stdvar="/tmp/$filename"
	if [ "$1" = "empty" ]; then
	else
		cat "${1:-/dev/stdin}" > $stdvar
	fi
}

