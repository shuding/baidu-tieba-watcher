//
//  AppDelegate.h
//  BaiduTiebaChecker
//
//  Created by Ds on 1/4/13.
//  Copyright (c) 2013 Ds. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	IBOutlet NSTextField *TBReplyField;
	IBOutlet NSTextField *TBTitleField;
	IBOutlet NSTextField *TBSubtitleField;
	IBOutlet NSTextField *TBAuthorField;
	IBOutlet NSTextField *TBLastreplyField;
	IBOutlet NSTextField *TBNameField;
	IBOutlet NSProgressIndicator *TBJuhua;
	IBOutlet NSButton *TBFresh;
	IBOutlet NSBox *TBBox;
	
	IBOutlet NSTextField *LSReplyField;
	IBOutlet NSTextField *LSTitleField;
	IBOutlet NSTextField *LSSubtitleField;
	IBOutlet NSTextField *LSAuthorField;
	IBOutlet NSTextField *LSLastreplyField;
	IBOutlet NSBox *LSBox;
	
	IBOutlet NSTextField *TBState;
	
	IBOutlet NSButton *TBAuto;
	IBOutlet NSTextField *TBDelaytime;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)refresh:(id)sender;
-(IBAction)autorefresh:(id)sender;

@end
