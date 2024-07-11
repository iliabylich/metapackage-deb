#!/usr/bin/env bash

set -eux

export BUILD_VERSION="0.0.$(date +%s)"

rm -rf /build
mkdir -p /build/metapackage-$BUILD_VERSION
cd /build/metapackage-$BUILD_VERSION

cp -r /shared/debian /build/metapackage-$BUILD_VERSION/debian
sed -i "s/VERSION_TEMPLATE/$BUILD_VERSION/g" /build/metapackage-$BUILD_VERSION/debian/changelog
sed -i "s/VERSION_TEMPLATE/$BUILD_VERSION/g" /build/metapackage-$BUILD_VERSION/debian/control

dpkg-buildpackage -b -us -uc

cd /build
ls -l

apt install --dry-run ./metapackage_$BUILD_VERSION\_amd64.deb

cp metapackage_$BUILD_VERSION\_amd64.deb /shared/metapackage_$BUILD_VERSION\_amd64.deb

cd /shared
dpkg-deb -c metapackage_$BUILD_VERSION\_amd64.deb
dpkg -I metapackage_$BUILD_VERSION\_amd64.deb
