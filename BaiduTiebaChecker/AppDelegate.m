//
//  AppDelegate.m
//  BaiduTiebaChecker
//
//  Created by Ds on 1/4/13.
//  Copyright (c) 2013 Ds. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

NSString *TBName, *TBReply, *TBTitle, *TBSubtitle, *TBAuthor, *TBLastreply, *TBReplytime;
NSURL *TBUrl;
NSData *TBData;
NSString *dataString;
NSStringEncoding enc;
NSRange TBList;
NSUserNotification *notification;
BOOL rep = 0;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	
	notification = [[NSUserNotification alloc] init];
	notification.title = @"贴吧潜水员来通知咯~";
	notification.subtitle = @">_<";
	notification.informativeText = @"有新帖子出现~";
	notification.hasActionButton = YES;
	notification.actionButtonTitle = @"详情";
	notification.otherButtonTitle = @"忽略";
	notification.soundName = NSUserNotificationDefaultSoundName;
	
	[TBJuhua startAnimation:self];
	TBName = @"noip";
	enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	TBUrl = [NSURL URLWithString: [[NSString stringWithFormat:@"http://tieba.baidu.com/f?ie=utf-8&kw=%@", TBName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	TBData = [TBUrl resourceDataUsingCache: NO];
	dataString = [[NSString alloc] initWithData:TBData encoding:enc];

	if([dataString rangeOfString:@"http://static.tieba.baidu.com/tb/static-frs/img/icon/zding.gif?v=1"].location != NSNotFound)
		while([dataString rangeOfString:@"http://static.tieba.baidu.com/tb/static-frs/img/icon/zding.gif?v=1"].location != NSNotFound){
			dataString = [dataString substringFromIndex:[dataString rangeOfString:@"http://static.tieba.baidu.com/tb/static-frs/img/icon/zding.gif?v=1"].location + 1];
			dataString = [dataString substringFromIndex:[dataString rangeOfString:@"threadlist_rep_num j_rp_num"].location];
		}
	
	TBList = [dataString rangeOfString:@"threadlist_rep_num j_rp_num"];
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	TBList.length = 0;
	while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
		TBList.length++;
	TBReply = [dataString substringWithRange:TBList];
	
	TBList = [dataString rangeOfString:@"notStarList"];
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	TBList.length = 0;
	while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
		TBList.length++;
	TBTitle = [dataString substringWithRange:TBList];
	
	TBList = [dataString rangeOfString:@"tb_icon_author"];
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	TBList.length = 0;
	while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
		TBList.length++;
	TBAuthor = [dataString substringWithRange:TBList];
	
	TBList = [dataString rangeOfString:@"threadlist_abs threadlist_abs_onlyline"];
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	TBList.length = 0;
	while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
		TBList.length++;
	TBSubtitle = [dataString substringWithRange:TBList];
	
	TBList = [dataString rangeOfString:@"tb_icon_author_rely j_replyer"];
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	TBList.length = 0;
	while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
		TBList.length++;
	TBLastreply = [dataString substringWithRange:TBList];
	
	TBList = [dataString rangeOfString:@"threadlist_reply_date j_reply_data"];
	while([dataString characterAtIndex:TBList.location] != '>')
		TBList.location++;
	TBList.location++;
	TBList.length = 0;
	while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
		TBList.length++;
	TBReplytime = [dataString substringWithRange:TBList];
	
	[TBReplyField setStringValue:TBReply];
	[TBTitleField setStringValue:TBTitle];
	[TBAuthorField setStringValue:TBAuthor];
	[TBSubtitleField setStringValue:TBSubtitle];
	[TBLastreplyField setStringValue:TBLastreply];
	[TBBox setTitle:[NSString stringWithFormat:@"最新帖子 @ %@", TBReplytime]];
	
	[LSReplyField setStringValue:TBReply];
	[LSTitleField setStringValue:TBTitle];
	[LSAuthorField setStringValue:TBAuthor];
	[LSSubtitleField setStringValue:TBSubtitle];
	[LSLastreplyField setStringValue:TBLastreply];
	[LSBox setTitle:[NSString stringWithFormat:@"次新帖子 @ %@", TBReplytime]];
	
	[TBJuhua stopAnimation:self];
	[dataString release];
}

-(IBAction)refresh:(id)sender
{
	[TBJuhua startAnimation:self];
	TBName = [TBNameField stringValue];
	
	TBUrl = [NSURL URLWithString: [[NSString stringWithFormat:@"http://tieba.baidu.com/f?ie=utf-8&kw=%@", TBName] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	TBData = [TBUrl resourceDataUsingCache: NO];
	dataString = [[NSString alloc] initWithData:TBData encoding:enc];
	
	if([dataString rangeOfString:@"http://static.tieba.baidu.com/tb/static-frs/img/icon/zding.gif?v=1"].location != NSNotFound)
		while([dataString rangeOfString:@"http://static.tieba.baidu.com/tb/static-frs/img/icon/zding.gif?v=1"].location != NSNotFound){
			dataString = [dataString substringFromIndex:[dataString rangeOfString:@"http://static.tieba.baidu.com/tb/static-frs/img/icon/zding.gif?v=1"].location + 1];
			dataString = [dataString substringFromIndex:[dataString rangeOfString:@"threadlist_rep_num j_rp_num"].location];
		}
	
	TBList = [dataString rangeOfString:@"threadlist_rep_num j_rp_num"];
	if(TBList.location != NSNotFound){
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		TBList.length = 0;
		while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
			TBList.length++;
		TBReply = [dataString substringWithRange:TBList];
	}
	else
		TBReply = [TBReplyField stringValue];
	
	TBList = [dataString rangeOfString:@"notStarList"];
	if(TBList.location != NSNotFound){
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		TBList.length = 0;
		while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
			TBList.length++;
		TBTitle = [dataString substringWithRange:TBList];
	}
	else
		TBTitle = [TBTitleField stringValue];

	TBList = [dataString rangeOfString:@"tb_icon_author"];
	if(TBList.location != NSNotFound){
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		TBList.length = 0;
		while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
			TBList.length++;
		TBAuthor = [dataString substringWithRange:TBList];
	}
	else
		TBAuthor = [TBAuthorField stringValue];
	
	TBList = [dataString rangeOfString:@"threadlist_abs threadlist_abs_onlyline"];
	if(TBList.location != NSNotFound){
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		TBList.length = 0;
		while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
			TBList.length++;
		TBSubtitle = [dataString substringWithRange:TBList];
	}
	else
		TBSubtitle = [TBSubtitleField stringValue];
	
	TBList = [dataString rangeOfString:@"tb_icon_author_rely j_replyer"];
	if(TBList.location != NSNotFound){
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		while([dataString characterAtIndex:TBList.location] != '>')
			TBList.location++;
		TBList.location++;
		TBList.length = 0;
		while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
			TBList.length++;
		TBLastreply = [dataString substringWithRange:TBList];
	}
	else
		TBLastreply = [TBLastreplyField stringValue];
	
	if([TBReply isEqualToString:[TBReplyField stringValue]] &&
	   [TBTitle isEqualToString:[TBTitleField stringValue]] &&
	   [TBAuthor isEqualToString:[TBAuthorField stringValue]] &&
	   [TBSubtitle isEqualToString:[TBSubtitleField stringValue]] &&
	   [TBLastreply isEqualToString:[TBLastreplyField stringValue]])
	{
		[TBState setStringValue:@"平静ing"];
	}
	else{
		TBReplytime = [[TBBox title] substringFromIndex:7];
		
		[LSReplyField setStringValue:[TBReplyField stringValue]];
		[LSTitleField setStringValue:[TBTitleField stringValue]];
		[LSAuthorField setStringValue:[TBAuthorField stringValue]];
		[LSSubtitleField setStringValue:[TBSubtitleField stringValue]];
		[LSLastreplyField setStringValue:[TBLastreplyField stringValue]];
		[LSBox setTitle:[NSString stringWithFormat:@"次新帖子 @ %@", TBReplytime]];

		TBList = [dataString rangeOfString:@"threadlist_reply_date j_reply_data"];
		if(TBList.location != NSNotFound){
			while([dataString characterAtIndex:TBList.location] != '>')
				TBList.location++;
			TBList.location++;
			TBList.length = 0;
			while([dataString characterAtIndex:TBList.location + TBList.length] != '<')
				TBList.length++;
			TBReplytime = [dataString substringWithRange:TBList];
		}

		[TBReplyField setStringValue:TBReply];
		[TBTitleField setStringValue:TBTitle];
		[TBAuthorField setStringValue:TBAuthor];
		[TBSubtitleField setStringValue:TBSubtitle];
		[TBLastreplyField setStringValue:TBLastreply];
		[TBBox setTitle:[NSString stringWithFormat:@"最新帖子 @ %@", TBReplytime]];
		
		notification.subtitle = [NSString stringWithFormat:@"%@在%@的帖子", TBAuthor, TBReplytime];
		notification.informativeText = TBTitle;
		[TBState setStringValue:@"新帖子出现 >_<"];
		
		notification.deliveryDate = [NSDate dateWithTimeIntervalSinceNow:1];
		[[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:notification];
//		[[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];

	}
	
	[TBJuhua stopAnimation:self];
	[dataString release];

}

-(IBAction)TBAuto:(id)sender
{
	if(rep == 1){
//		[NSThread sleepForTimeInterval:[[TBDelaytime stringValue] integerValue]];
		[self refresh:self];
		[self performSelector:@selector(TBAuto:) withObject:self afterDelay:[[TBDelaytime stringValue] integerValue]];
	}
}

-(IBAction)autorefresh:(id)sender
{
	if(rep == 0){
		[TBAuto setTitle:@"关闭自动刷新"];
		rep = 1;
		[self TBAuto:self];
	}
	else{
		[TBAuto setTitle:@"开启自动刷新"];
		rep = 0;
	}
}

@end
