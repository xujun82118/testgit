//
//  CustomImagePickerController.m
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "CustomImagePickerController.h"
#import "IphoneScreen.h"
#import "UIImage+Cut.h"
#import "ChooseStringViewController.h"

@interface CustomImagePickerController ()

@end

@implementation CustomImagePickerController

@synthesize customDelegate = _customDelegate, isDeclare=_isDeclare,isSingle=_isSingle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark get/show the UIView we want
- (UIView *)findView:(UIView *)aView withName:(NSString *)name {
	Class cl = [aView class];
	NSString *desc = [cl description];
	
	if ([name isEqualToString:desc])
		return aView;
	
	for (NSUInteger i = 0; i < [aView.subviews count]; i++) {
		UIView *subView = [aView.subviews objectAtIndex:i];
		subView = [self findView:subView withName:name];
		if (subView)
			return subView;
	}
	return nil;
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_header.png"];
    if (version >= 5.0) {
        [navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else{
        [navigationController.navigationBar insertSubview:[[UIImageView alloc] initWithImage:backgroundImage] atIndex:1];
    }
    

    
    if(self.sourceType == UIImagePickerControllerSourceTypeCamera){
        
        

    
        UIImage *deviceImage = [UIImage imageNamed:@"camera_button_switch_camera.png"];
        UIButton *deviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deviceBtn setBackgroundImage:deviceImage forState:UIControlStateNormal];
        [deviceBtn addTarget:self action:@selector(swapFrontAndBackCameras:) forControlEvents:UIControlEventTouchUpInside];
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        
        [deviceBtn setFrame:CGRectMake(250, 30, deviceImage.size.width, deviceImage.size.height)];
        
        UIView *PLCameraView=[self findView:viewController.view withName:@"PLCameraView"];
        [PLCameraView addSubview:deviceBtn];
        
        [self setShowsCameraControls:NO];
        
        
        
        if (_isDeclare) {
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
            NSInteger currentSelect = [defaults integerForKey:@"current"];
            
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, ScreenHeight-70-80, 280, 80)];
            
            //设置背景色
            //label1.backgroundColor = [UIColor grayColor];
           
            label1.tag = 91;
            //设置标签文本
            NSString *preString = @"Say:\n";
            
            label1.text = [preString stringByAppendingString:[[dataSourceArray objectAtIndex:currentSelect] objectForKey:@"kDeclareStringKey"]];
            
            //设置标签文本字体和字体大小
            label1.font = [UIFont fontWithName:@"Arial" size:20];
            label1.textColor = [UIColor whiteColor];
            
            //设置文本对其方式
            label1.textAlignment = UITextAlignmentCenter;
            //设置字体大小适应label宽度
            label1.adjustsFontSizeToFitWidth = YES;
            label1.numberOfLines = 4;
            /*
            UIImage *labelbgimage = [UIImage imageNamed:@"declare-bg.png"];
            UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(30, ScreenHeight-70-80, 280, 80)];
            bgImageView.image = labelbgimage;
            //[PLCameraView addSubview:bgImageView];
            */
            
            UITapGestureRecognizer *recognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDeclarePicker:)];
            
            recognizer1.numberOfTouchesRequired = 1;
            recognizer1.numberOfTapsRequired = 1;
            recognizer1.delegate = self;
            [label1 setUserInteractionEnabled:YES];
            [label1 addGestureRecognizer:recognizer1];
            [PLCameraView addSubview:label1];
            

            
            
        }
        
    
        UIView *overlyView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 70, 320, 44)];
        [overlyView setBackgroundColor:[UIColor clearColor]];
        
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backImage = [UIImage imageNamed:@"camera_cancel.png"];
        [backBtn setImage: backImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setFrame:CGRectMake(8, 5, backImage.size.width, backImage.size.height)];
        [overlyView addSubview:backBtn];
        
        UIImage *camerImage = [UIImage imageNamed:@"camera_shoot.png"];
        UIButton *cameraBtn = [[UIButton alloc] initWithFrame:
                               CGRectMake(/*110*/320/2-camerImage.size.width/2, 5, camerImage.size.width, camerImage.size.height)];
        [cameraBtn setImage:camerImage forState:UIControlStateNormal];
        [cameraBtn addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        [overlyView addSubview:cameraBtn];
        
        
        UIImage *photoImage = [UIImage imageNamed:@"camera_album.png"];
        UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 5, 70, 40)];
        [photoBtn setImage:photoImage forState:UIControlStateNormal];
        [photoBtn addTarget:self action:@selector(showPhoto) forControlEvents:UIControlEventTouchUpInside];
        
        [overlyView addSubview:photoBtn];
         
        self.cameraOverlayView = overlyView;
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;//隐藏为YES，显示为NO
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
	// Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    //[super dealloc];
}


#pragma mark - chooseDeclare
- (IBAction)chooseDeclarePicker:(UITapGestureRecognizer *)sender
{
   
    if (defaultPickerView == nil) {
        defaultPickerView = [[AFPickerView alloc] initWithFrame:CGRectMake(0,ScreenHeight-216,320,216) backgroundImage:@"PickerBG.png" shadowImage:@"PickerShadow.png" glassImage:@"pickerGlass.png" title:@"选择美丽宣言"];
        defaultPickerView.dataSource = self;
        defaultPickerView.delegate = self;
        defaultPickerView.rowFont = [UIFont fontWithName:@"Arial" size:20];
        [self.view addSubview:defaultPickerView];
    }
    [defaultPickerView showPicker];
    [defaultPickerView reloadData];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSInteger currentSelect = [defaults integerForKey:@"current"];
    defaultPickerView.selectedRow = currentSelect;
    
    
}


#pragma mark - ButtonAction Methods

- (IBAction)swapFrontAndBackCameras:(id)sender {
    if (self.cameraDevice ==UIImagePickerControllerCameraDeviceFront ) {
        self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }else {
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
}


- (void)closeView
{
    //[self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)takePicture
{

    [super takePicture];
}

- (void)showPhoto
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [image clipImageWithScaleWithsize:CGSizeMake(320, 480)] ;
    [picker dismissViewControllerAnimated:NO completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
        [_customDelegate cameraPhoto:image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    if(_isSingle){
        //[picker dismissModalViewControllerAnimated:YES];
        [picker dismissViewControllerAnimated:YES completion:NULL];
    }else{
        if(picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
            self.sourceType = UIImagePickerControllerSourceTypeCamera;
        }else{
            //[picker dismissModalViewControllerAnimated:YES];
            [picker dismissViewControllerAnimated:YES completion:NULL];
        }
    }
}



#pragma mark - AFPickerViewDataSource

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView {
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    return [dataSourceArray count];
    
}


- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    
    NSString *now = [[dataSourceArray objectAtIndex:row]objectForKey:@"kDeclareStringKey"];
    
    return now;
}


#pragma mark - AFPickerViewDelegate

- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row {

    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    [defaults setInteger:row forKey:@"current"];
    [defaults synchronize];
    
    UIView *PLCameraView=[self findView:self.view
                               withName:@"PLCameraView"];
    
    UILabel *label = (UILabel*)[PLCameraView viewWithTag:91];
    
    NSString *preString = @"Say:\n";
    
    label.text = [preString stringByAppendingString:[[dataSourceArray objectAtIndex:row] objectForKey:@"kDeclareStringKey"]];

    
}
@end
