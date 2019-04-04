export THEOS_DEVICE_IP=localhost -p 2222
TARGET = iphone:9.2:10.1
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SafariButtons
SafariButtons_FILES = Tweak.xm
SafariButtons_FRAMEWORKS = UIKit Foundation
SafariButtons_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/tweak.mk
after-stage::
	find . -name ".DS_STORE" -delete
after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += safaributtonsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
