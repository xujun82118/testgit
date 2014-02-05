//
//  CustomImagePickerController.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFPickerView.h"
@protocol CustomImagePickerControllerDelegate;

@interface CustomImagePickerController : UIImagePickerController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate,AFPickerViewDataSource, AFPickerViewDelegate>
{
    id<CustomImagePickerControllerDelegate> _customDelegate;
     AFPickerView *defaultPickerView;
}
@property(nonatomic)BOOL isSingle;
@property (nonatomic)BOOL isDeclare;
@property(nonatomic)id<CustomImagePickerControllerDelegate> customDelegate;
@end

//定义协议，一个统一的处理接口
@protocol CustomImagePickerControllerDelegate <NSObject>

- (void)cameraPhoto:(UIImage *)image;
- (void)cancelCamera;
@end
