//
//  SetMissionViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-11-3.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "SetMissionViewController.h"



@interface SetMissionViewController ()

@end

@implementation SetMissionViewController

@synthesize missionTableView, addMissionString,addString,addStringBackGround,editeString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.dataSourceArray = [defaults objectForKey:DEFAULT_MISSION_STRING_KEY];
   
    if (self.dataSourceArray == nil)
    {
        
        self.dataSourceArray = [NSMutableArray arrayWithObjects:
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
        
        
        
        [defaults setObject:self.dataSourceArray forKey:DEFAULT_MISSION_STRING_KEY];
        [defaults synchronize];
    }
    

    
    
    addMissionString.borderStyle = UITextBorderStyleBezel;
    addMissionString.textColor = [UIColor blackColor];
    addMissionString.font = [UIFont systemFontOfSize:17.0];
    addMissionString.placeholder = @"更多简单美丽任务。。。";
    addMissionString.backgroundColor = [UIColor whiteColor];
    
    addMissionString.keyboardType = UIKeyboardTypeDefault;
    addMissionString.returnKeyType = UIReturnKeyDone;
    addMissionString.secureTextEntry = NO;	// make the text entry secure (bullets)
    
    addMissionString.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
   
    addMissionString.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed


    addMissionString.hidden = YES;
    addString.hidden = YES;
    addStringBackGround.hidden = YES;
    
}


- (void) viewWillAppear:(BOOL)animated
{

    self.missionTableView.editing = NO;
    
    [editeString setTitle:@"编辑" forState:UIControlStateNormal];
    addMissionString.text = nil;
    
    addMissionString.hidden = YES;
    addString.hidden = YES;
    addStringBackGround.hidden = YES;
    
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 260.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [textField resignFirstResponder];
    //return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"mission count is %d", [self.dataSourceArray count]);
    //return 2;
    return [self.dataSourceArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cellmission";
    
    [tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:CellIdentifier];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kMissionStringKey"];
    //cell.imageView.image = [UIImage imageNamed:@"btn_back.png"];
    cell.backgroundColor = [UIColor clearColor];
    cell.opaque = YES;
   
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

//继承该方法时,左右滑动会出现删除按钮(自定义按钮),点击按钮时的操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObjectsFromArray:self.dataSourceArray];
    
    [mutaArray removeObjectAtIndex:indexPath.row];
    self.dataSourceArray = mutaArray;
    
    //[self.dataSourceArray removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    //存储自定认任务
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.dataSourceArray forKey:DEFAULT_MISSION_STRING_KEY];
    
    [defaults synchronize];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    // 列寬
    CGFloat contentWidth = self.view.frame.size.width;
    
    
    // 該行要顯示的內容
    NSString *content = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kMissionStringKey"];
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 500) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30]}  context:nil].size;
    // 這裏返回需要的高度
    return size.height;
    
}



- (IBAction)addNewMission:(id)sender {


    for (int i=0; i<self.dataSourceArray.count; i++)
    {
        NSString *now = [[self.dataSourceArray objectAtIndex:i]objectForKey:@"kMissionStringKey"];
        
        if ([self.addMissionString.text isEqualToString:now])
        {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:@"此任务已在任务列表中！"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles: nil];
            [alert show];
            
            return;
        }
        
    }
    
    if ([self.addMissionString.text isEqualToString:@""]) {
        return;
    }
    
    
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObjectsFromArray:self.dataSourceArray];
    
    [mutaArray addObject:[NSDictionary dictionaryWithObjectsAndKeys: self.addMissionString.text, @"kMissionStringKey",nil]];
    self.dataSourceArray =mutaArray;
    
    //[self.dataSourceArray addObject:
     //[NSDictionary dictionaryWithObjectsAndKeys: self.addMissionString.text, @"kMissionStringKey",nil]];

    //存储自定认任务
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];

    [defaults setObject:self.dataSourceArray forKey:DEFAULT_MISSION_STRING_KEY];
    
    [defaults synchronize];
				
    [missionTableView reloadData];
    
    NSInteger s = [self.missionTableView numberOfSections];
    if (s<1) return;
    NSInteger r = [self.missionTableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [self.missionTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    
    
}

- (IBAction)editString:(id)sender {
   
    
    [addStringBackGround setHidden:!addStringBackGround.hidden];
    [addMissionString setHidden:!addMissionString.hidden];
    [addString setHidden:!addString.hidden];

    [missionTableView setEditing:!self.missionTableView.editing animated:YES];
    
    if (self.missionTableView.editing == YES) {
        [editeString setTitle:@"完成" forState:UIControlStateNormal];
    }else
    {
        [editeString setTitle:@"编辑" forState:UIControlStateNormal];
        addMissionString.text = nil;
    }

}

- (IBAction)finishReturn:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
