# sync rom

repo init --depth=1 --no-repo-verify -u git://https://github.com/AospExtended/manifest.git -b 11.x default,-device,-mips,-darwin,-notdefault
git clone https://github.com/kryptoniteX/local_manifest.git --depth 1 -b aex_raphael .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
. build/envsetup.sh
lunch aosp_raphael-userdebug
export ALLOW_MISSING_DEPENDENCIES=TRUE #put before last build command
make bacon
# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/raphael/*.zip cirrus:raphael -P && rclone copy out/target/product/raphael/*.zip.json cirrus:raphael -P
