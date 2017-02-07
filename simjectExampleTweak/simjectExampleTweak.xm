#import <UIKit/UIKit.h>

@interface SBUIController : NSObject
	+(id)sharedInstance;
@end

%group IOS10
#define MAINWINDOW [[[NSClassFromString(@"SBUIController") sharedInstance] window] rootViewController]
%hook SpringBoard 
-(void)applicationDidFinishLaunching:(id)arg 
{
	%orig(arg);
	UIAlertController *lookWhatWorks = [UIAlertController alertControllerWithTitle:@"simject Example Tweak" 
											message:@"It works! (ﾉ´ヮ´)ﾉ*:･ﾟ✧"
											preferredStyle:UIAlertControllerStyleAlert];
	[lookWhatWorks addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault 
	handler: ^(UIAlertAction *action) 
		{
			[MAINWINDOW dismissViewControllerAnimated:YES completion:NULL]; 
		}
	]]; 
	[MAINWINDOW presentViewController:lookWhatWorks animated:YES completion:NULL]; 
}
%end
%end // end group IOS10


%group IOSother
%hook SpringBoard
	
-(void) applicationDidFinishLaunching:(id)arg 
{
	%orig(arg);
	UIAlertView *lookWhatWorks = [[UIAlertView alloc] initWithTitle:@"simject Example Tweak"
		message:@"It works! (ﾉ´ヮ´)ﾉ*:･ﾟ✧"
		delegate:self
		cancelButtonTitle:@"OK"
		otherButtonTitles:nil];
	[lookWhatWorks show];
}

%end
%end // end group IOS_other


%ctor {
	if(kCFCoreFoundationVersionNumber >= 1300) // iOS 10
    {
        %init(IOS10);
    }
    else
    {
        %init(IOSother);
    }
}
