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
    
    if (self.sectionObject) {
        self.title = [self.sectionObject.title stringByAppendingString:@" - 1/∞"];
        
        if ( ! activityIndicator) {
            activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            //                activityIndicator.center = self.view.center;
            activityIndicator.center = CGPointMake(160, 200);
            activityIndicator.hidesWhenStopped = YES;
            [self.view addSubview:activityIndicator];
        }
        
        if ([self.sectionObject pageCount] <= 0) { //内容为空，刷新
//            [activityIndicator startAnimating];
//            self.view.userInteractionEnabled = NO;
            [self.sectionObject refreshDataWithDeledate:self];
        }
        
        self.pageObject = [[PageObject alloc] initWithUrlString:[self.sectionObject.url stringByAppendingString:@"/index.html"]];
        if ([[self.pageObject itemsArray] count] <= 0) {
            [activityIndicator startAnimating];
            self.view.userInteractionEnabled = NO;
            [self.pageObject refreshDataWithDeledate:self];
        }
        
    }
    

//    self.clearsSelectionOnViewWillAppear = NO;
 
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
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
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
    return 40.0f;
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.text = [(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row] title];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
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
    
    PictureBrowserViewController *pictureBrowserViewController = [[PictureBrowserViewController alloc] initWithSection:self.sectionObject item:(ItemObject *)[[self.pageObject itemsArray] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:pictureBrowserViewController animated:YES];
    [pictureBrowserViewController release];
     
}

#pragma mark - SectionObjectDelegate

- (void)sectionDataFectchedSuccess {
//    [activityIndicator stopAnimating];
//    self.view.userInteractionEnabled = YES;
    self.title = [self.sectionObject.title stringByAppendingFormat:@" - %d/%d",[self.sectionObject currentPageIndex], [self.sectionObject pageCount]];
}

- (void)sectionDataFectchedFailed {
//    [activityIndicator stopAnimating];
//    self.view.userInteractionEnabled = YES;
}

- (void)pageDataFectchedSuccess {
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
    [self.tableView reloadData];
}

- (void)pageDataFectchedFailed {
    [activityIndicator stopAnimating];
    self.view.userInteractionEnabled = YES;
}

@end
