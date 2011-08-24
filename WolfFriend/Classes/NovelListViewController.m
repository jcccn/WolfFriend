//
//  NovelListViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/23/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "NovelListViewController.h"
#import "NovelBrowserViewController.h"
#import "NovelCatalogManager.h"
#import "SectionObject.h"
#import "ItemObject.h"

@implementation NovelListViewController

@synthesize sectionObject, pageObject;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSectionObject:(SectionObject *)aSectionObject {
    self = [super init];
    if (self) {
        self.sectionObject = aSectionObject;
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
    if ( ! self.tableView.tableFooterView) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        self.tableView.tableFooterView = footView;
        [footView release];
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
            activityIndicator.center = CGPointMake(160, 200);
            activityIndicator.hidesWhenStopped = YES;
            [self.view addSubview:activityIndicator];
        }
        [self startLoadItemList];
    }
    
    self.tableView.scrollsToTop = YES;
    
    
    if ( ! self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)] autorelease];
    }
}

- (void)refresh:(id)sender {
    if (activityIndicator && ![activityIndicator isAnimating]) {
        [[self.pageObject itemsArray] removeAllObjects];
        [self startLoadItemList];
    }
}

- (void)startLoadItemList {
    if ([self.sectionObject pageCount] <= 0) { //内容为空，刷新
        [activityIndicator startAnimating];
        self.view.userInteractionEnabled = NO;
        [self.sectionObject refreshDataWithDeledate:self];
    }
    else {
        self.pageObject = [self.sectionObject currentPageObject];
        self.title = [self.sectionObject.title stringByAppendingFormat:@" - %d/%d",[self.sectionObject currentPageIndex], [self.sectionObject pageCount]];
        self.tableView.tableFooterView.hidden = NO;
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    if (activityIndicator) {
        [activityIndicator stopAnimating];
        [activityIndicator release];
        activityIndicator = nil;
    }
    [super dealloc];
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
    NSInteger count = 0;
    if (self.pageObject) {
        //        count = [[self.sectionObject pages] count];
        count = [[self.pageObject itemsArray] count];
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellNovelList";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row] title];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    
    NovelBrowserViewController *novelBrowserViewController = [[NovelBrowserViewController alloc] initWithSection:self.sectionObject item:(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row]];
    novelBrowserViewController.title = [NSString stringWithString:[(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row] title]];
    [self.navigationController pushViewController:novelBrowserViewController animated:YES];
    [novelBrowserViewController release];
    
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
    [alert release];
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
