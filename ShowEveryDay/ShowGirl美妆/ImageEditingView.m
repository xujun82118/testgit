//
//  ImageEditingView.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-11.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "ImageEditingView.h"
#import "ChooseStringViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "AddWaterMask.h"


@interface ImageEditingView ()

@end

@implementation ImageEditingView

@synthesize editImage, imageEditingDelegate = imageEditingDelegate,saveImageBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        addWaterMask = [AddWaterMask alloc] ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	NSLog(@"image: %@", editImage);
    
	if (editImage != nil)
	{
		[ivEditingImage setImage:editImage];
		//[self.view sendSubviewToBack:ivEditingImage];
        [self.view addSubview:ivEditingImage];
        
        saveImageBtn.hidden = NO;
        [self.view addSubview:saveImageBtn];
	}else
    {
        saveImageBtn.hidden = YES;
    }
	

}


/*
+ (UIImage*)imageWithImage:(UIImage*)image
			  scaledToSize:(CGSize)newSize;
{
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

-(UIImage *)saveImage:(UIView *)view {
    CGRect mainRect = [[UIScreen mainScreen] bounds];
    
    UIGraphicsBeginImageContext(mainRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
	
    CGContextFillRect(context, mainRect);
    [view.layer renderInContext:context];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
	
    return newImage;
}

*/

- (IBAction)doFinishReturn:(id)sender {
    
    //[imageEditingDelegate imageEditingFinishReturn];
    [self dismissViewControllerAnimated:NO completion:^{
        [imageEditingDelegate imageEditingFinishReturn];
    }];

    
}

- (IBAction)doShare:(id)sender {
    
    /*
    actionSheetShare = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"分享到新浪微博", nil];//define other button with buttongIndex
    actionSheetShare.actionSheetStyle =UIActionSheetStyleBlackOpaque;//Define the actionsheet show style.
    [actionSheetShare showInView:self.view];//show actionsheet in the self view.
    */
    
    NSString* shareMsg;
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    NSInteger currentSelect = [defaults integerForKey:@"current"];
    
    NSString * preString = NSLocalizedString(@"FromUri", @"");
    shareMsg = [[[dataSourceArray objectAtIndex:currentSelect] objectForKey:@"kDeclareStringKey"] stringByAppendingString:preString];
    
    
    shareMsg =[@"早上好，亲，今天我的美丽宣言是：" stringByAppendingString:shareMsg];
    
    NSInteger contentType;
    if (editImage && shareMsg) {
        contentType = SSPublishContentMediaTypeNews;
        
        //加水印LOG
        editImage =[addWaterMask addImage:editImage addMsakImage:[UIImage imageNamed:@"waterlogo.png"]];
        
    }else{
        contentType = SSPublishContentMediaTypeText;
    }
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:shareMsg
                                       defaultContent:@"没有分享内容"
                                                image:[ShareSDK jpegImageWithImage:editImage
                                               quality:CGFLOAT_DEFINED]
                                                title:@"天天更美丽"
                                                  url:@"null"
                                          description:nil
                                            mediaType:contentType];
    NSArray *shareList = [ShareSDK getShareListWithType:
                          ShareTypeWeixiSession,
                          ShareTypeWeixiTimeline,
                          ShareTypeSinaWeibo,
                          ShareTypeTencentWeibo,
                          ShareTypeQQ,
                          ShareTypeCopy,
                          nil];
    [ShareSDK showShareActionSheet:nil
                         shareList:shareList
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
    //**********


}

//填充微博信息
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
   
   
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    NSInteger currentSelect = [defaults integerForKey:@"current"];
  
    NSString * preString = NSLocalizedString(@"FromUri", @"");
    message.text = [[[dataSourceArray objectAtIndex:currentSelect] objectForKey:@"kDeclareStringKey"] stringByAppendingString:preString];

 
    if (editImage!=Nil) {
        WBImageObject *image = [WBImageObject object];
        image.imageData = UIImagePNGRepresentation(editImage);
        //image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }
    
 

     /*
     if (self.mediaSwitch.on)
     {
     WBWebpageObject *webpage = [WBWebpageObject object];
     webpage.objectID = @"identifier1";
     webpage.title = @"分享网页标题";
     webpage.description = [NSString stringWithFormat:@"分享网页内容简介-%.0f", [[NSDate date] timeIntervalSince1970]];
     webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
     webpage.webpageUrl = @"http://sina.cn?a=1";
     message.mediaObject = webpage;
     }
     */
    
    return message;
}

- (IBAction)reDoPhoto:(id)sender {
    
    
    //调用自定义的图片处理控制器
       CustomImagePickerController* picker = [[CustomImagePickerController alloc] init];
        //判断是否有相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [picker setIsDeclare:YES];
        }else{
            [picker setIsSingle:YES];
            [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        [picker setCustomDelegate:self];

    //调起pick处理器，及其view
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)cameraPhoto:(UIImage *)image  //选择完图片
{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = image;
    //[self presentModalViewController:fitler animated:YES];
    [self presentViewController:fitler animated:YES completion:NULL];
    
}
- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    

    
    if (image != nil)
	{
		[ivEditingImage setImage:image];
		//[self.view sendSubviewToBack:ivEditingImage];
        editImage = image;
        [self.view addSubview:ivEditingImage];
        
        saveImageBtn.hidden = NO;
        [self.view addSubview:saveImageBtn];
        
        //存已照的相片，用于主界面
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *imageData = UIImageJPEGRepresentation(image, 100);
        [defaults setObject:imageData forKey:@"lastPhoto"];
        [defaults synchronize];
        
        //NSData * testimage = [defaults objectForKey:@"lastPhoto"];
        //UIImage *Image = [UIImage imageWithData:testimage];

	}else
    {
        saveImageBtn.hidden = YES;
    }
    
}


- (IBAction)saveImage:(id)sender
{
    
    
    //delegate functon will include actionSheet:several paramter.
    actionSheetSaveImage = [[UIActionSheet alloc]
                                  initWithTitle:nil//define the title
                                  delegate:self//transfer self as parameter to delegate function
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"保存到相册", nil];//define other button with buttongIndex
    actionSheetSaveImage.actionSheetStyle =UIActionSheetStyleBlackOpaque;//Define the actionsheet show style.
    [actionSheetSaveImage showInView:self.view];//show actionsheet in the self view.
    
}



//The first fun called by the delelgate. choose the buttonIndex to call the different fun.
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == actionSheetSaveImage) {
        if (buttonIndex == 0) {
            //加水印LOG
            editImage =[addWaterMask addImage:editImage addMsakImage:[UIImage imageNamed:@"waterlogo.png"]];
            UIImageWriteToSavedPhotosAlbum(editImage, nil, nil,nil);
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"保存成功！"
                                  message:nil//show the msg in the alert.
                                  delegate:self//delegate itself
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles: nil];
            [alert show];
        }else if (buttonIndex == 1) {
            //[self showAlert:@"取消"];
        }
    }else if (actionSheet == actionSheetShare)
    {
        if (buttonIndex == 0) {
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
            request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                 @"Other_Info_1": [NSNumber numberWithInt:123],
                                 @"Other_Info_2": @[@"obj1", @"obj2"],
                                 @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
            //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
            
            [WeiboSDK sendRequest:request];

        }else if (buttonIndex == 1) {
            //[self showAlert:@"取消"];
        }
        
    }

    
}


//called when home button is pressed, but not, it's wired.
- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    
    NSLog(@"ssssss");
    
}




//called after dismiss the actionsheet button
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}


//called will dismiss the actionsheet button
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    
}

@end
