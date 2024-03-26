#!/usr/bin/env sh
DIR=~/Downloads
MIRROR=https://github.com/tigerbeetle/tigerbeetle/releases/download

dl()
{
    local ver=$1
    local os=$2
    local arch=$3

    # https://github.com/tigerbeetle/tigerbeetle/releases/download/0.15.3/tigerbeetle-aarch64-linux.zip
    local url=$MIRROR/$ver/tigerbeetle-${arch}-${os}.zip

    local platform="${os}-${arch}"
    local lfile=${DIR}/tigerbeetle-${platform}-${ver}.zip
    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  %s:\n" $ver
    dl $ver macos universal
    dl $ver macos-debug universal
    dl $ver linux x86_64
    dl $ver linux-debug x86_64
    dl $ver linux aarch64
    dl $ver linux-debug aarch64
    dl $ver windows x86_64
    dl $ver windows-debug x86_64
}

dl_ver ${1:-0.15.3}
