//
//  ToolViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ToolViewController.h"
#import "ThemeDIYViewController.h"
#import "SiteDIYViewController.h"
#import "DisclaimerViewController.h"
#import "Helper.h"

#define TagAlertDefaultTheme    1000


@implementation ToolViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.clearsSelectionOnViewWillAppear = NO;
//    self.view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
    
    self.title = @"工具箱";
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetUI:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)resetUI:(id)arg {
    [self setBarBackroundColor:[[ThemeManager sharedManager] colorUIFrame]];
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    setIntPref(KeyScreenOrientation, sender.selectedSegmentIndex);
    [self.view setNeedsLayout];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    BOOL shouldAuto = NO;
//    switch (getIntPref(KeyScreenOrientation, 0)) {
//        case 0: {
//            shouldAuto = UIInterfaceOrientationIsPortrait(interfaceOrientation);;
//        }
//            break;
//            
//        case 1: {
//            shouldAuto = YES;
//        }
//            break;
//        case 2: {
//            shouldAuto = UIInterfaceOrientationIsLandscape(interfaceOrientation);
//        }
//            break;
//        default:
//            break;
//    }
//    return shouldAuto;
//}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    switch (section) {
        case 0:
            numberOfRows = 2;
            break;
        case 1:
            numberOfRows = 1;
            break;
        case 2:
            numberOfRows = 3;
            break;
        case 3:
            numberOfRows = 1;
            break;
        case 4:
            numberOfRows = 1;
            break;
        default:
            break;
    }
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellTool";
    static NSString *CellIdentifierWithSegment = @"CellToolSeg";
    static NSString *CellIdentifierWithSwitch = @"CellToolSwitch";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UITableViewCell *cellSeg = [tableView dequeueReusableCellWithIdentifier:CellIdentifierWithSegment];
    if (cellSeg == nil) {
        cellSeg = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierWithSegment];
    }
    UITableViewCell *cellSwitch = [tableView dequeueReusableCellWithIdentifier:CellIdentifierWithSwitch];
    if (cellSwitch == nil) {
        cellSwitch = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierWithSwitch];
    }
    // Configure the cell...
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"自定义主题";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    break;
                case 1:
                    cell.textLabel.text = @"恢复默认主题";
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            if (indexPath.row == 0) {
                cellSeg.textLabel.text = @"屏幕方向";
                cellSeg.selectionStyle = UITableViewCellSelectionStyleNone;
                UISegmentedControl *segmentedControl = nil;
                if ( ! cellSeg.accessoryView) {
                    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"竖屏", @"自动", @"横屏", nil]];
                    segmentedControl.frame = CGRectInset(segmentedControl.frame, 0, 5);
                    [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
                    cellSeg.accessoryView = segmentedControl;
                }
                segmentedControl = (UISegmentedControl *)cellSeg.accessoryView;
                segmentedControl.selectedSegmentIndex = getIntPref(KeyScreenOrientation, 0);
             
                return cellSeg;
            }
            
        }
            break;
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    cellSwitch.textLabel.text = @"本地保存";
                    cellSwitch.selectionStyle = UITableViewCellSelectionStyleNone;
                    if ( ! cellSwitch.accessoryView) {
                        UISwitch *aSwitch = [[UISwitch alloc] init];
                        aSwitch.frame = CGRectInset(aSwitch.frame, 0, 5);
                        [aSwitch setOn:NO];
                        cellSwitch.accessoryView = aSwitch;
                    }
                    return cellSwitch;
                }
                    break;
                case 1:
                    cell.textLabel.text = @"清除本地文件";
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                    break;
                case 2:
                    cell.textLabel.text = @"自定义网址";
                    cell.textLabel.textAlignment = UITextAlignmentCenter;
                    break;
                default:
                    break;
            }
        }
            break; 
        case 3: {
            cell.textLabel.text = @"分享";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
            break;
        case 4: {
            cell.textLabel.text = @"免责声明";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *titleHeader = @"";
    switch (section) {
        case 0:
            titleHeader = @"主题切换";
            break;
        case 1:
            titleHeader = @"屏幕设置";
            break;
        case 2:
            titleHeader = @"内容设置";
            break;
        default:
            break;
    }
    return titleHeader;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    NSString *titleHeader = @"";
//    switch (section) {
//        case 0:
//            titleHeader = @"  主题切换";
//            break;
//        case 1:
//            titleHeader = @"  屏幕设置";
//            break;
//        case 2:
//            titleHeader = @"  缓存设置";
//            break;
//        default:
//            break;
//    }
//    UILabel *headerView = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
//    [headerView setBackgroundColor:[UIColor clearColor]];
//    headerView.text = titleHeader;
//    return headerView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    //选择背景颜色、字体颜色、字体大小
                                         
                    ThemeDIYViewController *themeDIYViewController = [[ThemeDIYViewController alloc] init];
                    themeDIYViewController.navigationItem.hidesBackButton = YES;
                    [self.navigationController pushViewController:themeDIYViewController animated:YES];
                }
                    break;
                case 1: {
                    //选择内置主题
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定恢复默认？" message:@"恢复默认主题将丢失您的个性化设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                    alert.tag = TagAlertDefaultTheme;
                    [alert show];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            //屏幕方向
        }
            break;
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    //本地保存开关
                }
                    break;
                case 1: {
                   //清理缓存
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"谢谢惠待" message:@"此版本没有本地文件，无需清除" delegate:self cancelButtonTitle:@"知道啦" otherButtonTitles: nil];
                    [alert show];
                }
                    break;
                case 2: {
                    //自定义网址
                    SiteDIYViewController *siteDIYViewController = [[SiteDIYViewController alloc] init];
                    [self.navigationController pushViewController:siteDIYViewController animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3: {
            //分享
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不能随便传播哟" delegate:self cancelButtonTitle:@"知道啦，我很老实" otherButtonTitles: nil];
            [alert show];
        }
            break;
        case 4: {
            DisclaimerViewController *disclaimerViewController = [[DisclaimerViewController alloc] init];
            [self.navigationController pushViewController:disclaimerViewController animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case TagAlertDefaultTheme: {
            if (buttonIndex == 1) {
                [[ThemeManager sharedManager] loadDefaultTheme];
                [[ThemeManager sharedManager] saveTheme];
                [self resetUI:nil];
            }
        }
            break;
            
        default:
            break;
    }
}

@end
