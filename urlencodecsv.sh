#!/usr/bin/env bash

help() {
    if [ $# -eq 0 ] && [ -z /dev/stdin ]; then
	echo "This script transform text into URL encode."
	echo "Its input form stdin or a file name, and its output is stdout"
	echo
	exit 1
    fi
}

encodeline() {
    [[ "${1}" ]] || return 1
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
	    [:,/%]) echo -n "$c" ;;
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 | while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}

	    # ,) printf "$c" ;;
	    # /) printf "$c" ;;


help
while read line; do
    encodeline "$line"
    echo
done < "${1:-/dev/stdin}"
