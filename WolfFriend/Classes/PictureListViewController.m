//
//  PictureListViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "PictureListViewController.h"
#import "PictureBrowserViewController.h"
#import "PictureCatalogManager.h"
#import "SectionObject.h"
#import "ItemObject.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface PictureListViewController ()

- (void)dataCenterUpdated:(NSNotification *)notification;

@end

@implementation PictureListViewController

@synthesize sectionObject, pageObject;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSectionObject:(SubCategoryModel *)categoryModel {
    self = [super init];
    if (self) {
        self.categoryModel = categoryModel;
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
    
    self.title = self.categoryModel.categoryTitle;
    
    if ( ! self.tableView.tableFooterView) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        self.tableView.tableFooterView = footView;
        UIButton *prePageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        prePageButton.frame = CGRectMake(30, 5, 100, 40 );
        [prePageButton setTitle:@"上一页" forState:UIControlStateNormal];
        [prePageButton addTarget:self action:@selector(preButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableFooterView addSubview:prePageButton];
        UIButton *nextPageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        nextPageButton.frame = CGRectMake(190, 5, 100, 40 );
        [nextPageButton setTitle:@"下一页" forState:UIControlStateNormal];
        [nextPageButton addTarget:self action:@selector(nextButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableView.tableFooterView addSubview:nextPageButton];
        self.tableView.tableFooterView.hidden = YES;
    }
    
    if (self.sectionObject) {
        
        if ( ! activityIndicator) {
            activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            activityIndicator.center = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? CGPointMake(160, 200) : CGPointMake(240, 110);
            activityIndicator.hidesWhenStopped = YES;
            [self.view addSubview:activityIndicator];
        }
        [activityIndicator startAnimating];
        self.view.userInteractionEnabled = NO;
        [self performSelector:@selector(startLoadItemList) withObject:nil afterDelay:0.01];
    }
    
    self.tableView.scrollsToTop = YES;
 
    if ( ! self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataCenterUpdated:) name:@"CategoryDataUpdated" object:nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].removeFromSuperViewOnHide = YES;
    [[CategoryDataCenter sharedInstance] parseImageCategory:self.categoryModel];
}

- (void)dataCenterUpdated:(NSNotification *)notification {
    [self.tableView reloadData];
    [[MBProgressHUD HUDForView:self.view] hide:YES];
}

- (void)refresh:(id)sender {
    if (activityIndicator && ![activityIndicator isAnimating]) {
        [[self.pageObject itemsArray] removeAllObjects];
        [self startLoadItemList];
    }
}

- (void)startLoadItemList {
    if ([self.sectionObject pageCount] < 0) { //内容为空，刷新
        [activityIndicator startAnimating];
        self.view.userInteractionEnabled = NO;
        [self.sectionObject refreshDataWithDeledate:self];
    }
    else {
        self.pageObject = [self.sectionObject currentPageObject];
        self.title = [self.sectionObject.title stringByAppendingFormat:@" - %d/%d",[self.sectionObject currentPageIndex], [self.sectionObject pageCount]];
        self.tableView.tableFooterView.hidden = YES;
        if ([[self.pageObject itemsArray] count] <= 0) {
            [activityIndicator startAnimating];
            self.view.userInteractionEnabled = NO;
            [self.pageObject refreshDataWithDeledate:self];
        }
    }
}

- (void)startLoadNextItemList {
    self.pageObject = [self.sectionObject nextPageObject];
    if ([[self.pageObject itemsArray] count] <= 0) {
        [activityIndicator startAnimating];
        self.view.userInteractionEnabled = NO;
        [self.pageObject refreshDataWithDeledate:self];
    }
}

- (void)nextButtonClicked:(id)sender {
    PageObject *nextPageObject = [self.sectionObject nextPageObject];
    if (nextPageObject) {
        self.pageObject = nextPageObject;
        if ([[self.pageObject itemsArray] count] <= 0) {
            [activityIndicator startAnimating];
            self.view.userInteractionEnabled = NO;
            [self.pageObject refreshDataWithDeledate:self];
        }
    }
}

- (void)preButtonClicked:(id)sender {
    PageObject *prePageObject = [self.sectionObject prePageObject];
    if (prePageObject) {
        self.pageObject = prePageObject;
        if ([[self.pageObject itemsArray] count] <= 0) {
            [activityIndicator startAnimating];
            self.view.userInteractionEnabled = NO;
            [self.pageObject refreshDataWithDeledate:self];
        }
    }
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

- (void)viewWillDisappear:(BOOL)animated
{
//    if (self.pageObject) {
//        [self.pageObject stopRefreshDataWithDeledate:self];
//    }
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    UITabBarController *tabBarController = self.tabBarController;
    UITabBar *tabBar = tabBarController.tabBar;
    UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
    if (tabBarBackgroundView) {
        tabBarBackgroundView.frame = tabBar.bounds;
    }
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        activityIndicator.center = CGPointMake(160, 200);
    }
    else {
        activityIndicator.center = CGPointMake(240, 110);
    }
}

- (void)dealloc {
    if (activityIndicator) {
        [activityIndicator stopAnimating];
        activityIndicator = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.categoryModel.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellPictureList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [(ArticleModel *)self.categoryModel.articles[indexPath.row] articleTitle];
    
    // Configure the cell...
    
    return cell;
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
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    
//    PictureBrowserViewController *pictureBrowserViewController = [[PictureBrowserViewController alloc] initWithSection:self.sectionObject item:(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row]];
//    pictureBrowserViewController.title = [NSString stringWithString:[(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row] title]];
//    [self.navigationController pushViewController:pictureBrowserViewController animated:YES];
    
}

#pragma mark - SectionObjectDelegate

- (void)sectionDataFectchedSuccess {
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
    self.title = [self.sectionObject.title stringByAppendingFormat:@" - %d/%d",[self.sectionObject currentPageIndex], [self.sectionObject pageCount]];
    [self startLoadItemList];
}

- (void)sectionDataFectchedFailed {
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
    [self showAlert];
}

- (void)pageDataFectchedSuccess {
    if (!self.view) {
        return;
    }
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
    self.title = [self.sectionObject.title stringByAppendingFormat:@" - %d/%d",[self.sectionObject currentPageIndex], [self.sectionObject pageCount]];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    self.tableView.tableFooterView.hidden = NO;
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
}

- (void)pageDataFectchedFailed {
    if (!self.view) {
        return;
    }
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
    [self showAlert];
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"很遗憾" 
                                                    message:@"您没有得到想要的" 
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"重试", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            [self refresh:nil];
        }
            break;
            
        default:
            break;
    }
}

@end
