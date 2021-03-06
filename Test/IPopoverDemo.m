/*
 Copyright (c) 2014 ideawu. All rights reserved.
 Use of this source code is governed by a license that can be
 found in the LICENSE file.
 
 @author:  ideawu
 @website: http://www.cocoaui.com/
 */

#import "IPopoverDemo.h"
#import "IPopover.h"

@implementation IPopoverDemo


- (id)init{
	self = [super init];
	self.navigationItem.title = @"IPopoverDemo";
	self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
	
	return self;
}

- (void)viewDidLoad{
	[super viewDidLoad];

	{
		UIBarButtonItem *btn = [[UIBarButtonItem alloc]
								initWithBarButtonSystemItem:UIBarButtonSystemItemAction
								target:self action:@selector(showPopover)];
		self.navigationItem.rightBarButtonItem = btn;
	}
	
	// iOS 11
	{
		IButton *btn = [IButton buttonWithText:@"Toggle Navigation Bar"];
		[btn.style set:@"margin-bottom: 0; width: 100%; height: 40; background: #fff; border-bottom: 1px solid #ddd;"];
		
		__weak typeof(self) me = self;
		[btn addEvent:IEventClick handler:^(IEventType event, IView *view) {
			[me.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
		}];
		[self addIViewRow:btn];
	}
	
	{
		IButton *btn = [IButton buttonWithText:@"Pop Up"];
		[btn.style set:@"margin-bottom: 0; width: 100%; height: 40; background: #fff; border-bottom: 1px solid #ddd;"];
		
		__weak typeof(self) me = self;
		[btn addEvent:IEventHighlight|IEventUnhighlight|IEventClick handler:^(IEventType event, IView *view) {
			if(event == IEventClick){
				[me showPopover];
			}
		}];
		[self addIViewRow:btn];
	}

}

- (void)showPopover{
	log_debug(@"%s", __func__);
	log_debug(@"%@", NSStringFromCGRect(self.navigationController.navigationBar.frame));
	
	IView *view = [[IView alloc] init];
	//[view.style set:@"margin-top: 64;"];
	
	NSString *css = @"height: 150; color: #333; background: #fff; border: 1 solid #eee;";
	{
		IButton *btn = [IButton buttonWithText:@"A"];
		[btn.style set:css];
		[btn.style set:[NSString stringWithFormat:@"width: %f%%; border-right: 1 solid #eee;", 1.0/3 * 100]];
		[view addSubview:btn];
	}
	{
		IButton *btn = [IButton buttonWithText:@"B"];
		[btn.style set:css];
		[btn.style set:[NSString stringWithFormat:@"width: %f%%; border-right: 1 solid #eee;", 1.0/2 * 100]];
		[view addSubview:btn];
	}
	{
		IButton *btn = [IButton buttonWithText:@"C"];
		[btn.style set:css];
		[btn.style set:[NSString stringWithFormat:@"width: %f%%;", 1.0/1 * 100]];
		[view addSubview:btn];
	}
	
	IPopover *popover = [[IPopover alloc] init];
	[popover presentView:view onViewController:self.navigationController];
}

@end
