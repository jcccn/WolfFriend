//
//  PictureBrowserViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "PictureBrowserViewController.h"
#import "HTMLTool.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <BlocksKit/BlocksKit.h>
#import <BDMultiDownloader/BDMultiDownloader.h>
#import <ALAssetsLibrary-CustomPhotoAlbum/ALAssetsLibrary+CustomPhotoAlbum.h>

@interface PictureBrowserViewController () <UIWebViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIBarButtonItem *refreshButton;
@property (nonatomic, strong) UIBarButtonItem *downloadButton;

@property (nonatomic, strong) ArticleModel *articleModel;
@property (nonatomic, strong) NSArray *pictureUrls;

- (void)startLoadWebPage;
- (void)showAlert;
- (void)refreshRightBarButtons;
- (void)saveImages;

@end

@implementation PictureBrowserViewController

- (id)initWithArticle:(ArticleModel *)articleModel {
    self = [super init];
    if (self) {
        self.articleModel = articleModel;
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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.articleModel.articleTitle;
    
    UIWebView *aWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    aWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    aWebView.scalesPageToFit = YES;
    aWebView.delegate = self;
    self.webView = aWebView;
    [self.view addSubview:aWebView];
    
    self.refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    self.navigationItem.rightBarButtonItem = self.refreshButton;
    
    [self refresh:nil];
}

- (void)refresh:(id)sender {
    if ([MBProgressHUD HUDForView:self.view]) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    [hud showAnimated:YES whileExecutingBlock:^{
        [self startLoadWebPage];
    }];
}

- (void)startLoadWebPage {
    NSString *baseUrlString = @"http://cnsina8.com";
    NSString *urlString = [baseUrlString stringByAppendingPathComponent:self.articleModel.articleUrl];
    //截取网页部分
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]
                                                    encoding:NSUTF8StringEncoding
                                                       error:NULL];
    self.pictureUrls = [HTMLTool parseImagesFromHtml:htmlString];
    NSString *clearString = [HTMLTool parseImageBodyFromHtml:htmlString];
    if ([clearString length]) {
        [self.webView loadHTMLString:clearString baseURL:[NSURL URLWithString:baseUrlString]];
    }
    else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
    
    [self performSelectorOnMainThread:@selector(refreshRightBarButtons) withObject:nil waitUntilDone:NO];
}

- (void)refreshRightBarButtons {
    NSArray *rightBarButtons;
    if ([self.pictureUrls count]) {
        if ( ! self.downloadButton) {
            __weak __typeof(&*self)weakSelf = self;
            self.downloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                               handler:^(id sender) {
                                                                                   [weakSelf saveImages];
                                                                               }];
        }
        rightBarButtons = @[self.refreshButton, self.downloadButton];
    }
    else {
        rightBarButtons = @[self.refreshButton];
    }
    self.navigationItem.rightBarButtonItems = rightBarButtons;
}

- (void)saveImages {
    for (NSString *pictureUrl in self.pictureUrls) {
        [[BDMultiDownloader shared] imageWithPath:pictureUrl
                                       completion:^(UIImage *image, BOOL fromCache) {
                                           ALAssetsLibrary *assertsLibrary = [[ALAssetsLibrary alloc] init];
                                           [assertsLibrary saveImage:image
                                                             toAlbum:@"春暖花开"
                                                          completion:^(NSURL *assetURL, NSError *error) {
                                                              
                                                          }
                                                             failure:^(NSError *error) {
                                                                 
                                                             }];
                                       }];
    }
    
    self.navigationItem.rightBarButtonItems = @[self.refreshButton];
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

- (void)viewWillDisappear:(BOOL)animated {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [super viewWillDisappear:animated];
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL shouldStart = YES;
    return shouldStart;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {  
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;  
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
