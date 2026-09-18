# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="aic8800-firmware"
PKG_VERSION="1.0"
PKG_LICENSE="Proprietary"
PKG_SITE="https://www.aicsemi.com"
PKG_LONGDESC="AIC8800D80 SDIO WiFi firmware (AICSemi)"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/aic8800
  cp -a ${PKG_DIR}/aic8800D80 ${INSTALL}/$(get_full_firmware_dir)/aic8800/
}