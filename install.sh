if [ $(id -u) -ne 0 ]; then
  printf "Script must be run as root\n"
  exit 1
fi

curl -L https://github.com/cstrahan/osx-pl2303-kext/blob/master/osx-pl2303.kext.tgz?raw=true > osx-pl2303.kext.tgz
tar xvzf osx-pl2303.kext.tgz
cp -R osx-pl2303.kext /System/Library/Extensions/

rm osx-pl2303-kext.tgz
rm -rf osx-pl2303-kext

chmod -R 755 /System/Library/Extensions/osx-pl2303.kext
chown -R root:wheel /System/Library/Extensions/osx-pl2303.kext

kextload /System/Library/Extensions/osx-pl2303.kext
kextcache -system-cache

kextstat -b nl.bjaelectronics.driver.PL2303
