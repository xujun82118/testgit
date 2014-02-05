//
//  MissionTimeViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "MissionTimeViewController.h"
#import "SetupViewController.h"

@interface MissionTimeViewController ()

@end

@implementation MissionTimeViewController

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
	// Do any additional setup after loading the view.

    
    missionNotification=[[UILocalNotification alloc] init];
    
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDate *missioTime = [defaults valueForKey:DEFAULT_MISSION_TIME];
    
    NSDate *now = missioTime;
    [self.datePicker setDate:now animated:YES];
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doSelect:(id)sender {
    
    NSDate *selected = [self.datePicker date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    
    //当前的时分秒获得
    comps =[calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit)fromDate:selected];
    NSInteger hour = [comps hour];
    NSInteger miniute = [comps minute];
    NSString *message = [[NSString alloc] initWithFormat:
                         @"%d:%d", hour, miniute];
   
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setHour:hour];
    [components setMinute:miniute];
    [components setSecond:0];
    NSDate *fireDate = [calendar dateFromComponents:components];//目标时间
    

    //存用户选择的时间
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:fireDate forKey:DEFAULT_MISSION_TIME];
    [defaults synchronize];
    
    NSArray *myArray=[[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"local notify is %d", [myArray count]);
    for (int i=0; i<[myArray count]; i++)
    {
        UILocalNotification *myUILocalNotification=[myArray objectAtIndex:i];
        
        if ([[[myUILocalNotification userInfo] objectForKey:@"DeclareOrMissionTime"] isEqualToString:@"IsMissionTime"])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
        }
        
    }

    if (missionNotification!=nil)
    {
        [[UIApplication sharedApplication] cancelLocalNotification:missionNotification];
        missionNotification.fireDate = fireDate;
        missionNotification.repeatInterval = kCFCalendarUnitDay;
        missionNotification.timeZone=[NSTimeZone defaultTimeZone];
        missionNotification.alertBody = NSLocalizedString(@"Mission time is on", @"");
        missionNotification.soundName = @"alert.mp3";
        
        NSDictionary* info = [NSDictionary dictionaryWithObject:@"IsMissionTime" forKey:@"DeclareOrMissionTime"];
        missionNotification.userInfo = info;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:missionNotification];
        
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"定时时间为："
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Yes"
                          otherButtonTitles:nil];
    [alert show];
    
    [self dismissViewControllerAnimated:NO completion:NULL];

}

@end
