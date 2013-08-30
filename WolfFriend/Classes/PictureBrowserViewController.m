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

@interface PictureBrowserViewController () <UIWebViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) ArticleModel *articleModel;

- (void)startLoadWebPage;
- (void)showAlert;

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
    
    if ( ! self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    }
    
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
    NSString *clearString = [HTMLTool parseImageBodyFromHtml:htmlString];
    if ([clearString length]) {
        [self.webView loadHTMLString:clearString baseURL:[NSURL URLWithString:baseUrlString]];
    }
    else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    }
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
