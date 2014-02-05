//
//  HoldBeautyView.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-15.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImagePickerController.h"
#import "ImageFilterProcessViewController.h"
#import "AddWaterMask.h"


@interface HoldBeautyView : UIViewController<UITextFieldDelegate,CustomImagePickerControllerDelegate,ImageFitlerProcessDelegate, UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView* CurrentMissionTableView;
    
    
    UIActionSheet *actionSheetSaveImage;
    UIActionSheet *actionSheetShare;
    //CustomImagePickerController *picker;
    //ImageFilterProcessViewController *fitler;
    AddWaterMask* addWaterMask;
    
    NSInteger nowRow;//记忆当前选择
}

@property (nonatomic, retain) NSMutableArray *dataSourceArray;

@property (nonatomic, retain) UITableView *  CurrentMissionTableView;


@property (strong, nonatomic) IBOutlet UIButton *deleteImageButton;
@property (strong, nonatomic) IBOutlet UIButton *changeImageButton;
@property (strong, nonatomic) IBOutlet UIButton *saveImageButton;
- (IBAction)deleteImage:(id)sender;
- (IBAction)changeImage:(id)sender;
- (IBAction)saveImage:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *insertPhotoButton;
@property (strong, nonatomic) IBOutlet UIImageView *proveImage;
- (IBAction)insertPhoto:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *textSelfString;
//@property (strong, nonatomic) IBOutlet UISwitch *textSelf;

/*
- (IBAction)changeSwitchSelf:(id)sender;
- (IBAction)changeSwitch3:(id)sender;
- (IBAction)changeSwitch2:(id)sender;

- (IBAction)changeSwith1:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *textSelfString;
@property (strong, nonatomic) IBOutlet UILabel *text3String;
@property (strong, nonatomic) IBOutlet UILabel *text2String;
@property (strong, nonatomic) IBOutlet UILabel *text1String;
@property (strong, nonatomic) IBOutlet UISwitch *textSelf;
@property (strong, nonatomic) IBOutlet UISwitch *text3;
@property (strong, nonatomic) IBOutlet UISwitch *text2;
@property (strong, nonatomic) IBOutlet UISwitch *text1;
*/
 
- (IBAction)backToStart:(id)sender;
- (IBAction)doShare:(id)sender;
@end
