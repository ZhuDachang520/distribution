# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present ROCKNIX (https://github.com/ROCKNIX)

PKG_NAME="aic8800-sdio"
PKG_VERSION="516e3b087763d80c44f5e3b6d2dd63e0d925c91d"
PKG_SHA256="f79ff9b8b4dfed97c59fe6877b34406bbac042cc1091ada3bb17224fe62f1b39"
PKG_SOURCE_DIR="aic8800-${PKG_VERSION}"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/radxa-pkg/aic8800"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="AIC8800 SDIO out-of-tree WiFi driver (aic8800_bsp + aic8800_btlpm + aic8800_fdrv)"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  kernel_make -C $(kernel_path) \
    M=${PKG_BUILD}/src/SDIO/driver_fw/driver/aic8800 \
    CONFIG_PLATFORM_UBUNTU=n \
    CONFIG_AIC_FW_PATH=/lib/firmware/aic8800 \
    modules
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
  cp ${PKG_BUILD}/src/SDIO/driver_fw/driver/aic8800/aic8800_bsp/aic8800_bsp.ko \
     ${PKG_BUILD}/src/SDIO/driver_fw/driver/aic8800/aic8800_btlpm/aic8800_btlpm.ko \
     ${PKG_BUILD}/src/SDIO/driver_fw/driver/aic8800/aic8800_fdrv/aic8800_fdrv.ko \
     ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}

  mkdir -p ${INSTALL}/usr/lib/systemd/system
  cp ${PKG_DIR}/system.d/*.service ${INSTALL}/usr/lib/systemd/system
}

post_install() {
  enable_service aic8800-sdio.service
}