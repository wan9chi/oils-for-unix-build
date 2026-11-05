#!/bin/sh
set -xe

VERSION=$(cat version.txt)

rm -rf tmp
mkdir tmp

# A version like 0.38.0 builds that Oils release. A version like
# 0.38.0-git-<commit> builds the tarball that Oils CI made for that master
# commit, so fixes can ship before the next release. Use the full 40-character
# commit hash.
case "$VERSION" in
  *-git-*)
    COMMIT=${VERSION##*-git-}
    URL=https://op.oilshell.org/code/github-jobs/git-${COMMIT}/oils-for-unix.tar
    ;;
  *)
    URL=https://oils.pub/download/oils-for-unix-${VERSION}.tar.gz
    ;;
esac

curl -fL -o tmp/oils-for-unix.tar "$URL"
tar -xf tmp/oils-for-unix.tar -C tmp --strip-components=1
rm tmp/oils-for-unix.tar
