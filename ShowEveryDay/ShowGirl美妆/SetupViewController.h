//
//  SetupViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeclareTimePickerViewController.h"
#import "MissionTimeViewController.h"
#import "ChooseStringViewController.h"
#import "SetMissionViewController.h"

#define DEFAULTS_IS_DECLARE_TIME @"defaultsIsDeclareTime7"
#define DEFAULTS_IS_MISSION_TIME @"defaultsIsMissionTime"

@interface SetupViewController : UIViewController
{
    IBOutlet DeclareTimePickerViewController* declareTime;
    IBOutlet MissionTimeViewController* missionTime;
    IBOutlet ChooseStringViewController* chooseDeclare;
    IBOutlet SetMissionViewController* setUpMission;

}
- (IBAction)setupMissonString:(id)sender;
- (IBAction)setupMissionTime:(id)sender;
- (IBAction)setupDeclareTime:(id)sender;
- (IBAction)chooseDeclare:(id)sender;
- (IBAction)isDeclareTimeChanged:(id)sender;
- (IBAction)isMissionTimeChanged:(id)sender;

- (IBAction)weiBoMe:(id)sender;
- (IBAction)addStars:(id)sender;

@property (strong, nonatomic) IBOutlet UISwitch *isEveryDayMission;
@property (strong, nonatomic) IBOutlet UISwitch *isEveryDayDeclare;


- (IBAction)finishSetup:(id)sender;

@end
