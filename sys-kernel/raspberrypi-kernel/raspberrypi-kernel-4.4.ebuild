# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/raspberrypi"
CROS_WORKON_PROJECT="linux"
#EGIT_REPO_URI="https://github.com/raspberrypi/linux.git"
EGIT_BRANCH="master"
#EGIT_BRANCH="rpi-4.4.y"
CROS_WORKON_BLACKLIST="1"
# get github latest
CROS_WORKON_COMMIT="0926c07dec16ca75cc01c06201c19be7086d3a4b"
#CROS_WORKON_COMMIT="04c8e47067d4873c584395e5cb260b4f170a99ea"
#EGIT_COMMIT="04c8e47067d4873c584395e5cb260b4f170a99ea"

#EGIT_COMMIT="806e02221caec4ca42adc7aed42f5523bc8fb0dc"

#cros_WORKON_COMMIT="f6d3e0ef4b07fc33c0a9e86abedb36776a953736"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel-raspberrypi2-kms"
KEYWORDS="arm"
KERNEL="kernel7"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
	cros-kernel2_src_install
	"${D}/../work/raspberrypi-kernel/scripts/mkknlimg" \
                "$(cros-workon_get_build_dir)/arch/arm/boot/zImage" \
                "${T}/kernel.img"

	insinto /firmware/rpi
	doins "${FILESDIR}"/{cmdline,config}.txt
	doins "${T}/kernel.img"
	doins "$(cros-workon_get_build_dir)/arch/arm/boot/dts/bcm2709-rpi-2-b.dtb"
	doins -r "$(cros-workon_get_build_dir)/arch/arm/boot/dts/overlays"
}

