#include "SBSRootListController.h"

@implementation SBSRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}
- (void)launchTwitter:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/junesiphone"]];
}
- (void)launchInstagram:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/junesiphone/"]];
}
- (void)launchWebsite:(id)sender {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://junesiphone.com/"]];
}
- (void)respring:(id)sender {
    NSTask *task = [[[NSTask alloc] init] autorelease];
    [task setLaunchPath:@"/usr/bin/killall"];
    [task setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
    [task launch];
}
@end
