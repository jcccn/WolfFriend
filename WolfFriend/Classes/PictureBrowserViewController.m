//
//  PictureBrowserViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "PictureBrowserViewController.h"
#import "ItemObject.h"
#import "SectionObject.h"

@implementation PictureBrowserViewController

@synthesize webView, sectionObject, itemObject;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithSection:(SectionObject *)section item:(ItemObject *)item {
    self = [super init];
    if (self) {
        self.sectionObject = section;
        self.itemObject = item;
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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *aWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44-50)];
    aWebView.scalesPageToFit = YES;
    aWebView.delegate = self;
    self.webView = aWebView;
    [self.view addSubview:aWebView];
    
    if ( ! activityIndicator) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //                activityIndicator.center = self.view.center;
        activityIndicator.center = UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]) ? CGPointMake(160, 200) : CGPointMake(240, 110);
        activityIndicator.hidesWhenStopped = YES;
        [self.view addSubview:activityIndicator];
    }
    
    [self performSelectorInBackground:@selector(startLoadWebPage) withObject:nil];
    
    if ( ! self.navigationItem.rightBarButtonItem) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh:)];
    }
}

- (void)refresh:(id)sender {
    if (activityIndicator && ![activityIndicator isAnimating]) {
        [self.webView stopLoading];
        [self performSelectorInBackground:@selector(startLoadWebPage) withObject:nil];
    }
}

- (void)startLoadWebPage {
    @autoreleasepool {
    
        if (activityIndicator) {
            [activityIndicator startAnimating];
        }
        NSString *urlString = self.itemObject.url;
        NSString *baseUrlString = self.sectionObject.url;    
        //截取网页部分
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        if ([data length] == 0) {
            if (activityIndicator) {
                [activityIndicator stopAnimating];
            }
            [self showAlert];
            return;
        }
        NSString *resourceText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //    NSLog(@"resourceText:%@",resourceText);
        NSString *bodyString = [HTMLTool parseImageBodyFromHtml:resourceText];
        //    NSLog(@"bodyString:%@",bodyString);
        [self.webView loadHTMLString:bodyString baseURL:[NSURL URLWithString:baseUrlString]];
        if (activityIndicator) {
            [activityIndicator stopAnimating];
        }
    
    }
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

- (void)resetUI:(id)arg {
    [self setBarBackroundColor:[[ThemeManager sharedManager] colorUIFrame]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    BOOL shouldAuto = NO;
    switch (getIntPref(KeyScreenOrientation, 0)) {
        case 0: {
            shouldAuto = UIInterfaceOrientationIsPortrait(interfaceOrientation);;
        }
            break;
            
        case 1: {
            shouldAuto = YES;
        }
            break;
        case 2: {
            shouldAuto = UIInterfaceOrientationIsLandscape(interfaceOrientation);
        }
            break;
        default:
            break;
    }
    return shouldAuto;
}

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



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL shouldStart = YES;
//    if (([request.URL.absoluteString isEqualToString:@"http://www.64aaa.com"]) || ([request.URL.absoluteString isEqualToString:@"http://www.64aaa.com/"])) {
    if ([request.URL.path isEqualToString:@"/"]) {
        shouldStart = NO;
    }
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
    [self showAlert];
}

@end
