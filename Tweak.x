#import <UIKit/UIKit.h>
#import "MediaRemote.h"

%hook SpringBoard
-(_Bool)_handlePhysicalButtonEvent:(UIPressesEvent *)event {
	UIPress *volUp = nil;
	UIPress *volDown = nil;

	for (UIPress *press in [[event allPresses] allObjects]) {
		if (press.type == 102 && press.force == 1) { // volume up
			volUp = press;
		} else if (press.type == 103 && press.force == 1) { // volume down
			volDown = press;
		}
	}

	if (volUp && volDown) {
		MRMediaRemoteSendCommand(kMRTogglePlayPause, nil);
	}

	return %orig;
}
%end
