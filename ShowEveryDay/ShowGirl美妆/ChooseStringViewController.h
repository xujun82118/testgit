//
//  ChooseStringViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-20.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h> 

#define DEFAULT_CHOOSE_STRING_KEY  @"DefaultChooseString"
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface ChooseStringViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView* declareTableView;
    NSInteger currentSelect;
    
}
- (IBAction)editString:(id)sender;

- (IBAction)finishReturn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *addDeclareString;
@property (strong, nonatomic) IBOutlet UIButton *addString;
@property (strong, nonatomic) IBOutlet UIImageView *addStringBackGround;
@property (strong, nonatomic) IBOutlet UIButton *editeString;
- (IBAction)addNewDeclare:(id)sender;


@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@property (nonatomic, retain) UITableView *  declareTableView;
@end
