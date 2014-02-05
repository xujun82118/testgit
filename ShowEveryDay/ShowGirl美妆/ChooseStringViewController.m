//
//  ChooseStringViewController.m
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-10-20.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import "ChooseStringViewController.h"




@interface ChooseStringViewController ()

@end

static NSString *CellTableIdentifier = @"CellTableIdentifier";

@implementation ChooseStringViewController

@synthesize declareTableView, addDeclareString,addString,addStringBackGround,editeString;

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

    // Uncomment the following line to preserve selection between presentations.

    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    self.dataSourceArray = [defaults objectForKey:DEFAULT_CHOOSE_STRING_KEY];


    addDeclareString.borderStyle = UITextBorderStyleBezel;
    addDeclareString.textColor = [UIColor blackColor];
    addDeclareString.font = [UIFont systemFontOfSize:17.0];
    addDeclareString.placeholder = @"更多美丽宣言。。。";
    addDeclareString.backgroundColor = [UIColor whiteColor];
    
    addDeclareString.keyboardType = UIKeyboardTypeDefault;
    addDeclareString.returnKeyType = UIReturnKeyDone;
    addDeclareString.secureTextEntry = NO;	// make the text entry secure (bullets)
    
    addDeclareString.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
    
    addDeclareString.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
    

    
    
    addDeclareString.hidden = YES;
    addString.hidden = YES;
    addStringBackGround.hidden = YES;
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    
    [declareTableView setEditing:NO animated:YES];
    
    [editeString setTitle:@"编辑" forState:UIControlStateNormal];
    addDeclareString.text = nil;
    
    addDeclareString.hidden = YES;
    addString.hidden = YES;
    addStringBackGround.hidden = YES;
    
    NSInteger s = [self.declareTableView numberOfSections];
    if (s<1) return;
    NSInteger r = [self.declareTableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSInteger selected = [defaults integerForKey:@"current"];
    
    if (selected>r) {
        return;
    }
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:selected inSection:s-1];
    [declareTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:YES];

   // [declareTableView reloadData];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 250.0);//键盘高度216
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



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   NSLog(@"declare count is %d", [self.dataSourceArray count]);
    return [self.dataSourceArray count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cellchoose";
    
    [tableView registerClass:[UITableViewCell class]  forCellReuseIdentifier:CellIdentifier];

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...

    
	cell.textLabel.text = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kDeclareStringKey"];
    //cell.imageView.image = [UIImage imageNamed:@"btn_back.png"];
    cell.backgroundColor = [UIColor clearColor];
    cell.opaque = YES;
    
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    currentSelect = [defaults integerForKey:@"current"];
    
    NSLog(@"---current = %d",currentSelect);
    
    if (indexPath.row == currentSelect) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewRowAnimationMiddle];
        cell.imageView.image = [UIImage imageNamed:@"选择.png"];
        

    }else
    {
        cell.imageView.image = nil;
    }

    
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

    
 // 列寬
 CGFloat contentWidth = self.view.frame.size.width;

 
 // 該行要顯示的內容
 NSString *content = [[self.dataSourceArray objectAtIndex:indexPath.row] objectForKey:@"kDeclareStringKey"];
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(contentWidth, 500) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:30]}  context:nil].size;
    // 這裏返回需要的高度
    return size.height;
 
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

//继承该方法时,左右滑动会出现删除按钮(自定义按钮),点击按钮时的操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.dataSourceArray count] == 1) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"请留一条宣言哦~"
                              delegate:nil
                              cancelButtonTitle:@"Yes"
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObjectsFromArray:self.dataSourceArray];
    
    [mutaArray removeObjectAtIndex:indexPath.row];
    self.dataSourceArray = mutaArray;
    //[self.dataSourceArray removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    //存储自定认任务
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.dataSourceArray forKey:DEFAULT_CHOOSE_STRING_KEY];
    
    [defaults synchronize];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    cell.imageView.image = [UIImage imageNamed:@"选择.png"];
 
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setInteger:indexPath.row forKey:@"current"];

    [defaults synchronize];
    
    [declareTableView reloadData];
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.imageView.image = nil;
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}




/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)editString:(id)sender {
    
    [addStringBackGround setHidden:!addStringBackGround.hidden];
    [addDeclareString setHidden:!addDeclareString.hidden];
    [addString setHidden:!addString.hidden];
    
    [declareTableView setEditing:!self.declareTableView.editing animated:YES];
    
    if (self.declareTableView.editing == YES) {
        [editeString setTitle:@"完成" forState:UIControlStateNormal];
    }else
    {
        [editeString setTitle:@"编辑" forState:UIControlStateNormal];
        addDeclareString.text = nil;
        
        //判读已选择列已被删了
        NSIndexPath *indexPath = [declareTableView indexPathForSelectedRow];
        if (!indexPath) {
            [declareTableView reloadData];//此时焦点需重加载
            return;
        }
        
        NSInteger s = [self.declareTableView numberOfSections];
        if (s<1) return;
        NSInteger r = [self.declareTableView numberOfRowsInSection:s-1];
        if (r<1) return;
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        NSInteger selected = [defaults integerForKey:@"current"];
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:selected inSection:s-1];
        [declareTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionMiddle animated:YES];

    }

}

- (IBAction)finishReturn:(id)sender {
    
    
    //判读已选择列已被删了
    NSIndexPath *indexPath = [declareTableView indexPathForSelectedRow];
    if (!indexPath) {
        
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:nil
                              message:@"请选择一条宣言哦~"
                              delegate:nil
                              cancelButtonTitle:@"Yes"
                              otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
    /*
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSInteger selected = [defaults integerForKey:@"current"];
    
    if (selected > [self.dataSourceArray count]) {
        [defaults setInteger:0 forKey:@"current"];
        [defaults synchronize];
    }
*/
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)addNewDeclare:(id)sender
{
    for (int i=0; i<self.dataSourceArray.count; i++)
    {
        NSString *now = [[self.dataSourceArray objectAtIndex:i]objectForKey:@"kDeclareStringKey"];
        
        if ([self.addDeclareString.text isEqualToString:now])
        {
            
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:nil
                                  message:@"此宣言已在任务列表中！"
                                  delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles: nil];
            [alert show];
            
            return;
        }
        
    }
    
    if ([self.addDeclareString.text isEqualToString:@""]) {
        return;
    }
    
    NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
    [mutaArray addObjectsFromArray:self.dataSourceArray];
    
    [mutaArray addObject:[NSDictionary dictionaryWithObjectsAndKeys: self.addDeclareString.text, @"kDeclareStringKey",nil]];
    self.dataSourceArray =mutaArray;
    
    //[self.dataSourceArray addObject:
    // [NSDictionary dictionaryWithObjectsAndKeys: self.addDeclareString.text, @"kDeclareStringKey",nil]];
    
    //存储自定认任务
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    [defaults setObject:self.dataSourceArray forKey:DEFAULT_CHOOSE_STRING_KEY];
    
    [defaults synchronize];
    
    [declareTableView reloadData];

    NSInteger s = [self.declareTableView numberOfSections];
    if (s<1) return;
    NSInteger r = [self.declareTableView numberOfRowsInSection:s-1];
    if (r<1) return;
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:r-1 inSection:s-1];
    
    [self.declareTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionBottom animated:YES];

    
}

@end
