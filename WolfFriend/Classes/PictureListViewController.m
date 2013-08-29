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
#import <MBProgressHUD/MBProgressHUD.h>

@interface PictureListViewController ()

@property (nonatomic, strong) SubCategoryModel *categoryModel;

- (void)dataCenterUpdated:(NSNotification *)notification;

@end

@implementation PictureListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithSubCategory:(SubCategoryModel *)categoryModel {
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
    
    self.tableView.scrollsToTop = YES;
 
    if ( ! self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataCenterUpdated:) name:@"CategoryDataUpdated" object:nil];
    [self refresh:nil];
}

- (void)refresh:(id)sender {
    if ([MBProgressHUD HUDForView:self.view]) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES].removeFromSuperViewOnHide = YES;
    self.tableView.tableFooterView.hidden = YES;
    [[CategoryDataCenter sharedInstance] parseImageCategory:self.categoryModel];
}

- (void)dataCenterUpdated:(NSNotification *)notification {
    [self.tableView reloadData];
    self.tableView.tableFooterView.hidden = YES;
    [[MBProgressHUD HUDForView:self.view] hide:YES];
}

- (void)startLoadNextItemList {
    
}

- (void)nextButtonClicked:(id)sender {
    
}

- (void)preButtonClicked:(id)sender {
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)resetUI:(id)arg {
    [self setBarBackroundColor:[[ThemeManager sharedManager] colorUIFrame]];
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
    
    ArticleModel *article = self.categoryModel.articles[indexPath.row];
    
    PictureBrowserViewController *pictureBrowserViewController = [[PictureBrowserViewController alloc] initWithArticle:article];

    [self.navigationController pushViewController:pictureBrowserViewController animated:YES];
    
}

@end
