#!/usr/bin/env bash

encodeline() {
    # urlencode <string>
    [[ "${1}" ]] || return 1
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%s' "$c" | xxd -p -c1 |
                   while read c; do printf '%%%s' "$c"; done ;;
        esac
    done
}

while read line; do
    encodeline "$line"
    echo
done < "${1:-/dev/stdin}"
