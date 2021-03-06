#
# Copyright (c) 2018, ARM Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: BSD-3-Clause
#

include plat/arm/css/sgi/sgi-common.mk

SGI575_BASE		=	plat/arm/board/sgi575

PLAT_INCLUDES		+=	-I${SGI575_BASE}/include/

SGI_CPU_SOURCES		:=	lib/cpus/aarch64/cortex_a75.S

BL1_SOURCES		+=	${SGI_CPU_SOURCES}

BL2_SOURCES		+=	${SGI575_BASE}/sgi575_plat.c		\
				${SGI575_BASE}/sgi575_security.c	\
				drivers/arm/tzc/tzc_dmc620.c		\
				lib/utils/mem_region.c			\
				plat/arm/common/arm_nor_psci_mem_protect.c

BL31_SOURCES		+=	${SGI_CPU_SOURCES}			\
				${SGI575_BASE}/sgi575_plat.c		\
				drivers/cfi/v2m/v2m_flash.c		\
				lib/utils/mem_region.c			\
				plat/arm/common/arm_nor_psci_mem_protect.c

# Add the FDT_SOURCES and options for Dynamic Config
FDT_SOURCES		+=	${SGI575_BASE}/fdts/${PLAT}_tb_fw_config.dts
TB_FW_CONFIG		:=	${BUILD_PLAT}/fdts/${PLAT}_tb_fw_config.dtb

# Add the TB_FW_CONFIG to FIP and specify the same to certtool
$(eval $(call TOOL_ADD_PAYLOAD,${TB_FW_CONFIG},--tb-fw-config))

FDT_SOURCES		+=	${SGI575_BASE}/fdts/${PLAT}.dts
HW_CONFIG		:=	${BUILD_PLAT}/fdts/${PLAT}.dtb

# Add the HW_CONFIG to FIP and specify the same to certtool
$(eval $(call TOOL_ADD_PAYLOAD,${HW_CONFIG},--hw-config))
