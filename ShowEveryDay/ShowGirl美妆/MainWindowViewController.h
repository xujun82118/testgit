//
//  MainWindowViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
@class StartView;

@interface MainWindowViewController : UIViewController<EAIntroDelegate>
- (IBAction)startView:(id)sender;
- (void)startOneOffTimer:(id)sender;
-(void)targetMethodStartView:(NSTimer*)theTimer;
- (NSDictionary *)userInfo;

@property (retain, nonatomic) StartView* startViewController;
@end
