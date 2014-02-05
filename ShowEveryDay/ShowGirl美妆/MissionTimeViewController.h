//
//  MissionTimeViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_MISSION_TIME @"defaultMissionTime"

@interface MissionTimeViewController : UIViewController
{
        UILocalNotification *missionNotification;
    
}

- (IBAction)doSelect:(id)sender;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
