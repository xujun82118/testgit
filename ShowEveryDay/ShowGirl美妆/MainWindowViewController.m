//
//  MainWindowViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "MainWindowViewController.h"
#import "StartView.h"
#import "ChooseStringViewController.h"
#import "SetMissionViewController.h"

@interface MainWindowViewController ()

@end

@implementation MainWindowViewController

@synthesize startViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //初始化start界面
    self.startViewController = [[StartView alloc] initWithNibName:@"StartView" bundle:nil];
    
    if (self.startViewController == nil) {
        NSLog(@"startViewController == nil");
    }

    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSMutableArray *dataSourceArray=[defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];
    if (dataSourceArray== nil)
    {
        dataSourceArray = [NSMutableArray arrayWithObjects:
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            NSLocalizedString(@"DeclareString_1", @""), @"kDeclareStringKey",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            NSLocalizedString(@"DeclareString_2", @""),@"kDeclareStringKey",
                            nil],
                           [NSDictionary dictionaryWithObjectsAndKeys:
                            NSLocalizedString(@"DeclareString_3", @""), @"kDeclareStringKey",
                            nil],
                           nil];
        [defaults setObject:dataSourceArray forKey:DEFAULT_CHOOSE_STRING_KEY];
        [defaults synchronize];
        
    }
    
    dataSourceArray = [defaults objectForKey:DEFAULT_MISSION_STRING_KEY];
    
    if (dataSourceArray == nil)
    {
        
        dataSourceArray = [NSMutableArray arrayWithObjects:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"Mission_1", @""), @"kMissionStringKey",
                                 nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"Mission_2", @""), @"kMissionStringKey",
                                 nil],
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 NSLocalizedString(@"Mission_3", @""), @"kMissionStringKey",
                                 nil],
                                nil];
        
        
        
        [defaults setObject:dataSourceArray forKey:DEFAULT_MISSION_STRING_KEY];
        [defaults synchronize];
    }
    
    //[defaults setInteger:0 forKey:@"current"];
    
    //[defaults synchronize];
    
/*
    [UIView beginAnimations:@"Start View" context:nil];
 
    [UIView setAnimationDuration:10.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //设置动画方式
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    

    
    //显示相关的view
    [logoViewController.view removeFromSuperview];
    [self.view insertSubview:self.startViewController.view atIndex:0 ];
    
    //退出函数时，应用之
    [UIView  commitAnimations];
*/
    
    //起动定时延时器
    //[self startOneOffTimer:nil];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    // all settings are basic, pages with custom packgrounds, title image on each page
  
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL isFirstTime = [defaults boolForKey:@"isFirstTimeUse"];
    if (isFirstTime == NO) {
        
        [self showIntroWithCrossDissolve];
        [defaults setBool:YES forKey:@"isFirstTimeUse"];
        
    }
    
}


- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    //page1.title = @"";
    //page1.desc = @"";
    //page1.bgImage = [UIImage imageNamed:@"intro-1"];
    page1.titleImage = [UIImage imageNamed:@"intro-1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    //page2.title = @"";
    //page2.desc = @"";
    //page2.bgImage = [UIImage imageNamed:@"intro-2"];
    page2.titleImage = [UIImage imageNamed:@"intro-2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    //page3.title = @"";
    //page3.desc = @"";
    //page3.bgImage = [UIImage imageNamed:@"intro-3"];
    page3.titleImage = [UIImage imageNamed:@"intro-3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}


- (void)showIntroWithCrossDissolve1 {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"1"];
    page1.titleImage = [UIImage imageNamed:@"original"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"2"];
    page2.titleImage = [UIImage imageNamed:@"supportcat"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"3"];
    page3.titleImage = [UIImage imageNamed:@"femalecodertocat"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}


- (void)introDidFinish {
    NSLog(@"Intro callback");
}

- (void)startOneOffTimer:sender
{
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(targetMethodStartView:)
                                    userInfo:[self userInfo]
                                    repeats:NO];
}

- (NSDictionary *)userInfo {
    return @{ @"StartDate" : [NSDate date] };
}

-(void)targetMethodStartView:(NSTimer*)theTimer
{
    NSLog(@"Into tartget timer!");
    
    [self startView:nil];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startView:(id)sender {
    
    [UIView beginAnimations:@"Start View" context:nil];
    
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    //设置动画方式
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:startViewController.view cache:YES];
    
    
    //显示相关的view
    [self presentViewController:startViewController animated:YES completion:NULL];
    
    //退出函数时，应用之
    [UIView  commitAnimations];
    
    
}
@end
