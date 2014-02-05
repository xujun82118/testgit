//
//  DeclareTimePickerViewController.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-18.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DECLARE_TIME @"DefaultDeclareTime"

@interface DeclareTimePickerViewController : UIViewController
{
    
    UILocalNotification *declareNotification;
    
}

- (IBAction)doSelect:(id)sender;


@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
