#!/bin/bash
if [ $# -lt 1 ]; then
	echo "Usage: $0 <new_root>" >&2
	exit 1
fi
root_dir=$(realpath $1)
PATH=$PATH:$root_dir/usr/bin
readarray -d '' lib_folders < <(find $root_dir/usr/lib -type d -print0)
for folder in ${lib_folders[@]}; do
	LD_LIBRARY_PATH+=:$folder
	LIBRARY_PATH+=:$folder
done

readarray -d '' inc_folders < <(find $root_dir/usr/include -type d -print0)
for folder in ${inc_folders[@]}; do
	C_INCLUDE_PATH+=:$folder
done

export PKG_CONFIG_PATH="\$PKG_CONFIG_PATH:$root_dir/usr/lib/x86_64-linux-gnu/pkgconfig/"
echo "export PATH=\$PATH$PATH"
echo
echo "export LIBRARY_PATH=\$LIBRARY_PATH$LIBRARY_PATH"
echo
echo "export LD_LIBRARY_PATH=\$LD_LIBRARY_PATH$LD_LIBRARY_PATH"
echo
echo "export C_INCLUDE_PATH=\$C_INCLUDE_PATH$C_INCLUDE_PATH"
echo "export PKG_CONFIG_PATH=\$PKG_CONFIG_PATH$PKG_CONFIG_PATH"
