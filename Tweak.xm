#import <objc/runtime.h>
#import <libcolorpicker.h>

//static NSString *nsDomainString = @"com.junesiphone.safaributtonsettings";
static NSString *nsNotificationString = @"com.junesiphone.safaributtonsettings/preferences.changed";

/* reference to settings for app settings */
NSString *settingsPath = @"/var/mobile/Library/Preferences/com.junesiphone.safaributtonsettings.plist";
static NSMutableDictionary *prefs = nil;
static NSMutableDictionary *CPSettings;

// State: button when url is selected, on new page, and bookmarks
%hook UIButton
-(id)tintColor{
	UIColor* color = %orig;
	if([[prefs objectForKey:@"enabled"] boolValue]){
		CGFloat red,green,blue,alpha;
		[color getRed:&red green:&green blue:&blue alpha:&alpha];
		if(blue == 1.0f){
			color = LCPParseColorString([CPSettings objectForKey:@"textColor"], @"#000000");
		}
	}
	return color;
}
%end

// State: progress bar
%hook _SFFluidProgressView
	-(void)setProgressBarFillColor:(UIColor*) color{
		if([[prefs objectForKey:@"enabled"] boolValue]){
			CGFloat red,green,blue,alpha;
			[color getRed:&red green:&green blue:&blue alpha:&alpha];
			if(blue == 1.0f){
				%orig(LCPParseColorString([CPSettings objectForKey:@"progressColor"], @"#000000"));
			}else{
				%orig;
			}
		}else{
			%orig;
		}
	}
%end

// State: bookmark icons
%hook UITableView
-(id)tintColor{
	UIColor* color = %orig;
	if([[prefs objectForKey:@"enabled"] boolValue]){
		CGFloat red, green, blue, alpha;
		[color getRed:&red green:&green blue:&blue alpha:&alpha];
		if(blue == 1.0f){
			color = LCPParseColorString([CPSettings objectForKey:@"bookmarkColor"], @"#000000");
		}
	}
	return color;
}
%end

// State: when you go to create another page
%hook UIView
-(void)setBackgroundColor:(UIColor *) color{
	if([[prefs objectForKey:@"enabled"] boolValue]){
		CGFloat red, green, blue, alpha;
		[color getRed:&red green:&green blue:&blue alpha:&alpha];
		if(alpha == 0.73){ //panel at bottom of the page has alpha
			if(ceil(red * 100) == 11.0 && ceil(green * 100) == 11.0 && ceil(blue * 100) == 11.0){
				//%orig([[UIColor whiteColor] colorWithAlphaComponent:0.4]);
				%orig(LCPParseColorString([CPSettings objectForKey:@"newPanel"], @"#ffffff:0.5"));
			}else{
				%orig;
			}
		}else{
			%orig;
		}
	}else{
		%orig;
	}
}
%end

// State: bottom buttons
%hook UIImageView
-(id)tintColor{
	UIColor* color = %orig;
	if([[prefs objectForKey:@"enabled"] boolValue]){
		CGFloat red,green,blue,alpha;
		[color getRed:&red green:&green blue:&blue alpha:&alpha];
		if(blue == 1.0f){
			if(self.frame.size.width == 21.0f || red == 0.0f){ //plus icon to add new safari page. red blocks KB
				color =  LCPParseColorString([CPSettings objectForKey:@"bottomIcons"], @"#000000");
			}
		}
	}
	return color;
}
%end


/* get options from settings */
static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	CPSettings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/private/var/mobile/Library/Preferences/com.junesiphone.safaributtonsettings.color.plist"];
}


%ctor {
	notificationCallback(NULL, NULL, NULL, NULL, NULL);
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
		NULL,
		notificationCallback,
		(CFStringRef)nsNotificationString,
		NULL,
		CFNotificationSuspensionBehaviorCoalesce);
}
