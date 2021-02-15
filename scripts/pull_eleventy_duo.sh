# Copyright 2021 Sean Kelleher. All rights reserved.
# Use of this source code is governed by an MIT
# licence that can be found in the LICENCE file.

# `$0 <dir>` fetches a specific version of of `eleventy-duo` and stores it at
# `dir`.

set -o errexit

if [ $# -ne 1 ] ; then
    echo "usage: $0 <dir>" >&2
    exit 1
fi

dir="$1"

cleanup() {
    rm -rf "$dir"
    exit 1
}

git clone 'https://github.com/yinkakun/eleventy-duo' "$dir" \
    || cleanup

cd "$dir" \
    || cleanup

git checkout '77413f5352a3ddc692a75a1d6c2a6768781e7870' \
    || cleanup
