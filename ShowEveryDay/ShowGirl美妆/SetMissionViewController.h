//
//  SetMissionViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-11-3.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_MISSION_STRING_KEY @"DefaultMissionString"



@interface SetMissionViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

{
    IBOutlet UITableView* missionTableView;
    
}
@property (strong, nonatomic) IBOutlet UITextField *addMissionString;
@property (strong, nonatomic) IBOutlet UIButton *addString;
@property (strong, nonatomic) IBOutlet UIImageView *addStringBackGround;
@property (strong, nonatomic) IBOutlet UIButton *editeString;
- (IBAction)addNewMission:(id)sender;
- (IBAction)editString:(id)sender;

- (IBAction)finishReturn:(id)sender;

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@property (nonatomic, retain) UITableView *  missionTableView;

@end
