//
//  ImageFilterProcessViewController.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ImageFitlerProcessDelegate;
@interface ImageFilterProcessViewController : UIViewController
{
    UIImageView *rootImageView;
    UIScrollView *scrollerView;
    UIImage *currentImage;
    id <ImageFitlerProcessDelegate> delegate;
}
@property(nonatomic) id<ImageFitlerProcessDelegate> delegate;
@property(nonatomic)UIImage *currentImage;
@end

@protocol ImageFitlerProcessDelegate <NSObject>

- (void)imageFitlerProcessDone:(UIImage *)image;
@end
