#! /bin/sh

set -e

srcdir=$(cd `dirname "$0"` && pwd)

rm -rf build
mkdir build
cd build

package=$(egrep '^Package:' ${srcdir}/debian/control|cut -c10-)
version=$(egrep '^Version:' ${srcdir}/debian/control|cut -c10-)
output="${package}-${version}_all.deb"

mkdir -p usr/share/ca-certificates/ben-crannich
cp ${srcdir}/root-a1/root-a1.crt.pem  usr/share/ca-certificates/ben-crannich/BenCrannich-Root-A1.crt
cp ${srcdir}/root-b1/root-b1.crt.pem  usr/share/ca-certificates/ben-crannich/BenCrannich-Root-B1.crt
cp ${srcdir}/inter-x1/inter-x1.a1.crt.pem usr/share/ca-certificates/ben-crannich/BenCrannich-Intermediate-X1.crt

cp -r ${srcdir}/debian DEBIAN
cd ..
printf "Building %s...\n" "${output}" >&2
dpkg-deb --root-owner-group -b build ${output}


