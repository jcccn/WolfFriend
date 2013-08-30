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
#import <KKPasscodeLock/KKPasscodeLock.h>
#import <KKPasscodeLock/KKPasscodeSettingsViewController.h>

#define TagAlertDefaultTheme    1000

@interface ToolViewController () <KKPasscodeSettingsViewControllerDelegate>

@end

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
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
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    break;
                default:
                    break;
            }
        }
            break;
            
        case 1: {
            cell.textLabel.text = @"密码锁定";
            cell.detailTextLabel.text = ([[KKPasscodeLock sharedLock] isPasscodeRequired] ? @"开启" : @"关闭");
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    break;
                case 2:
                    cell.textLabel.text = @"自定义网址";
                    cell.textLabel.textAlignment = NSTextAlignmentCenter;
                    break;
                default:
                    break;
            }
        }
            break; 
        case 3: {
            cell.textLabel.text = @"分享";
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
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
            titleHeader = @"隐私设置";
            break;
        case 2:
            titleHeader = @"内容设置";
            break;
        default:
            break;
    }
    return titleHeader;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

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
            KKPasscodeSettingsViewController *viewController = [[KKPasscodeSettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
            viewController.delegate = self;
            [self.navigationController pushViewController:viewController animated:YES];
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

#pragma mark - KKPasscodeSettingsViewControllerDelegate

- (void)didSettingsChanged:(KKPasscodeSettingsViewController*)viewController {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
