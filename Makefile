TARGET := iphone:clang:latest:15.0
ARCHS = arm64

THEOS_PACKAGE_SCHEME = rootless

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = LiquidLock

LiquidLock_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk
