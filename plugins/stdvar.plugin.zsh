
stdvar() {
	local filename=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')
	export stdvar="/tmp/$filename"
	cat "${1:-/dev/stdin}" > $stdvar
}

