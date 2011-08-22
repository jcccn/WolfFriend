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
    self.webView = aWebView;
    [self.view addSubview:aWebView];
    [webView release];
    
    if ( ! activityIndicator) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //                activityIndicator.center = self.view.center;
        activityIndicator.center = CGPointMake(160, 200);
        activityIndicator.hidesWhenStopped = YES;
        [self.view addSubview:activityIndicator];
    }
    
    [self performSelectorInBackground:@selector(startLoadWebPage) withObject:nil];
}

- (void)startLoadWebPage {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    if (activityIndicator) {
        [activityIndicator startAnimating];
    }
    NSString *urlString = self.itemObject.url;
    NSString *baseUrlString = self.sectionObject.url;    
    //截取网页部分
    NSURL *url = [NSURL URLWithString:urlString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *resourceText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //    NSLog(@"resourceText:%@",resourceText);
    NSString *bodyString = [HTMLTool parseImageBodyFromHtml:resourceText];
    //    NSLog(@"bodyString:%@",bodyString);
    [self.webView loadHTMLString:bodyString baseURL:[NSURL URLWithString:baseUrlString]];
    if (activityIndicator) {
        [activityIndicator stopAnimating];
    }
    
    [pool release];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [super dealloc];
}

@end
