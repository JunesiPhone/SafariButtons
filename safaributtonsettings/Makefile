include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SafariButtonSettings
SafariButtonSettings_FILES = SBSRootListController.m
SafariButtonSettings_INSTALL_PATH = /Library/PreferenceBundles
SafariButtonSettings_FRAMEWORKS = UIKit
SafariButtonSettings_PRIVATE_FRAMEWORKS = Preferences
SafariButtonSettings_LIBRARIES = colorpicker
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SafariButtonSettings.plist$(ECHO_END)
