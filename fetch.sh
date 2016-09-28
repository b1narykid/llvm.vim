#!/bin/sh

URL="${1:-"https://llvm.org/svn/llvm-project/llvm/trunk/utils/vim"}"
OUT="${2:-.}"

fetch() {
	echo "==> Downloading $1 to $2..."
	curl $1 > $2
}

fetch_dir() {
	local dir="$1"

	mkdir -p "$OUT/$dir"

	for file in "${@:2}"
	do
		fetch "$URL/$dir/$file" "$OUT/$dir/$file"
	done
}

echo "Fetching README file..." &&
fetch "$URL/README" "$OUT/LLVM_README" &&

echo && echo "Fetching VimL sources..." &&
fetch_dir syntax  	llvm.vim tablegen.vim	&&
fetch_dir indent  	llvm.vim             	&&
fetch_dir ftplugin	llvm.vim tablegen.vim	&&
fetch_dir ftdetect	llvm.vim tablegen.vim

# vim:noet:ts=8:sw=8:
