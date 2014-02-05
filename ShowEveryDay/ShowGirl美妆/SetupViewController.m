//
//  SetupViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "SetupViewController.h"
#import <ShareSDK/ShareSDK.h>

@interface SetupViewController ()

@end

@implementation SetupViewController

@synthesize isEveryDayDeclare,isEveryDayMission;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    isEveryDayDeclare.on = [defaults boolForKey:DEFAULTS_IS_DECLARE_TIME];
    isEveryDayMission.on = [defaults boolForKey:DEFAULTS_IS_MISSION_TIME];
    
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (isEveryDayDeclare.on == NO) {
        NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (int i=0; i<[myArray count]; i++)
        {
            UILocalNotification *myUILocalNotification=[myArray objectAtIndex:i];
            
            if ([[[myUILocalNotification userInfo] objectForKey:@"DeclareOrMissionTime"] isEqualToString:@"IsDeclareTime"])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
            }
            
        }
    }
    
    
    if (isEveryDayMission.on == NO) {
        NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (int i=0; i<[myArray count]; i++)
        {
            UILocalNotification *myUILocalNotification=[myArray objectAtIndex:i];
            
            if ([[[myUILocalNotification userInfo] objectForKey:@"DeclareOrMissionTime"] isEqualToString:@"IsMissionTime"])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
            }
            
        }
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)finishSetup:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)setupMissonString:(id)sender {
    
    [self presentViewController:setUpMission animated:YES completion:NULL];

    
}

- (IBAction)setupMissionTime:(id)sender {
    
    [self presentViewController:missionTime animated:YES completion:NULL];

    
}

- (IBAction)setupDeclareTime:(id)sender {
    
    [self presentViewController:declareTime animated:YES completion:NULL];

}


- (IBAction)chooseDeclare:(id)sender{
    
    [self presentViewController:chooseDeclare animated:YES completion:nil];

}

- (IBAction)isDeclareTimeChanged:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isEveryDayDeclare.on forKey:DEFAULTS_IS_DECLARE_TIME];
    [defaults synchronize];


    
    if (isEveryDayDeclare.on==NO) {
        NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (int i=0; i<[myArray count]; i++)
        {
            UILocalNotification *myUILocalNotification=[myArray objectAtIndex:i];
            
            if ([[[myUILocalNotification userInfo] objectForKey:@"DeclareOrMissionTime"] isEqualToString:@"IsDeclareTime"])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
            }
            
        }
    }else
    {
        NSDate *declareTime = [defaults valueForKey:DEFAULT_DECLARE_TIME];
        UILocalNotification *declareNotification=[[UILocalNotification alloc] init];
        if (declareNotification!=nil)
        {
            declareNotification.fireDate = declareTime;
            declareNotification.repeatInterval = kCFCalendarUnitDay;
            declareNotification.timeZone=[NSTimeZone defaultTimeZone];
            declareNotification.alertBody = NSLocalizedString(@"Declare time is on", @"");
            declareNotification.soundName = @"alert.mp3";
          
            NSDictionary* info = [NSDictionary dictionaryWithObject:@"IsDeclareTime" forKey:@"DeclareOrMissionTime"];
            declareNotification.userInfo = info;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:declareNotification];
            
        }
    }
    
    

}

- (IBAction)isMissionTimeChanged:(id)sender
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:isEveryDayMission.on forKey:DEFAULTS_IS_MISSION_TIME];
    [defaults synchronize];
    
    if (isEveryDayMission.on==NO) {
        NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
        for (int i=0; i<[myArray count]; i++)
        {
            UILocalNotification *myUILocalNotification=[myArray objectAtIndex:i];
            
            if ([[[myUILocalNotification userInfo] objectForKey:@"DeclareOrMissionTime"] isEqualToString:@"IsMissionTime"])
            {
                [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
            }
            
        }
    }else
    {
        NSDate *missioTime = [defaults valueForKey:DEFAULT_MISSION_TIME];
        UILocalNotification *missionNotification=[[UILocalNotification alloc] init];
        if (missionNotification!=nil)
        {
            
            missionNotification.fireDate = missioTime;
            missionNotification.repeatInterval = kCFCalendarUnitDay;
            missionNotification.timeZone=[NSTimeZone defaultTimeZone];
            missionNotification.alertBody = NSLocalizedString(@"Mission time is on", @"");
            missionNotification.soundName = @"alert.mp3";
            
            NSDictionary* info = [NSDictionary dictionaryWithObject:@"IsMissionTime" forKey:@"DeclareOrMissionTime"];
            missionNotification.userInfo = info;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:missionNotification];
            
        }
    }

    
}

- (IBAction)weiBoMe:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"亲的任何意见，我都无比重视^_^"
                          message:nil//show the msg in the alert.
                          delegate:self//delegate itself
                          cancelButtonTitle:@"确定"
                          otherButtonTitles: nil];
    [alert show];
    

}


- (IBAction)addStars:(id)sender
{
    
//    NSString *str = [NSString stringWithFormat:
//                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
//                     782426992 ];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"去给'%@'打分吧！",@"天天更美丽"]
//                                                        message:@"您的评价对我们很重要"
//                                                       delegate:self
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"稍后评价",@"去评价",nil];
//    [alertView show];
    
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/app/tian-tian-geng-mei-li/id782426992?ls=1&mt=8"];
    [[UIApplication sharedApplication] openURL:url];
}

#pragma mark -
#pragma mark alertView delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    NSString*  shareMsg = @"@星星汰:";
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:shareMsg
                                       defaultContent:@"没有分享内容"
                                                image:nil
                                                title:@"天天更美丽"
                                                  url:@"null"
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    //在授权页面中添加关注官方微博
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"星星汰1982"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    nil]];
    
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    
    //显示分享菜单
    [ShareSDK showShareViewWithType:ShareTypeSinaWeibo
                          container:container
                            content:publishContent
                      statusBarTips:YES
                        authOptions:authOptions
                       shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                           oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                            qqButtonHidden:NO
                                                     wxSessionButtonHidden:NO
                                                    wxTimelineButtonHidden:NO
                                                      showKeyboardOnAppear:NO
                                                         shareViewDelegate:nil
                                                       friendsViewDelegate:nil
                                                     picViewerViewDelegate:nil]
                             result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                 
                                 if (state == SSPublishContentStateSuccess)
                                 {
                                     NSLog(@"发表成功");
                                 }
                                 else if (state == SSPublishContentStateFail)
                                 {
                                     NSLog(@"发布失败!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                 }
                             }];

    
    
    
}



@end
