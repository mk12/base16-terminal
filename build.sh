#!/bin/bash

set -eufo pipefail

usage() {
    cat <<EOS
usage: $0 [-h]

Builds Base16 themes in out/kitty/.
EOS
}

die() {
    echo "$0: $*" >&2
    exit 1
}

main() {
    cd "$(dirname "$0")"
    if ! [[ -d build/schemes ]]; then
        die "build/schemes: directory not found (try './update.sh')"
    fi
    if ! command -v pybase16 &>/dev/null; then
        die "pybase16: command not found (try 'pip install pybase16-builder')"
    fi
    local -a targets=(kitty)
    local target
    local -a template_args=()
    for target in "${targets[@]}"; do
        mkdir -p "build/templates/$target/templates"
        cp "templates/$target/"{config.yaml,default.mustache} "build/templates/$target/templates"
        template_args+=(-t "$target")
    done
    cd build
    rm -rf output
    pybase16 build "${template_args[@]}"
    cd ..
    rm -rf out
    mkdir out
    for target in "${targets[@]}"; do
        mv "build/output/$target/colors" "out/$target"
    done
}

while getopts "h" opt; do
    case $opt in
        h) usage; exit 0 ;;
        *) exit 1 ;;
    esac
done

main
