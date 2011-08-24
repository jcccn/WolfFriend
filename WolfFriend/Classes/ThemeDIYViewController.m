//
//  ThemeDIYViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ThemeDIYViewController.h"
#import "ThemeManager.h"

@implementation ThemeDIYViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"DIY主题";
    self.view.backgroundColor = [[ThemeManager sharedManager] uiColorWithWebColor:[[ThemeManager sharedManager] backgroudColor]];
    if ( ! scrollView) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:scrollView];
        [scrollView release];
    }
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat contentHeight = screenRect.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
    scrollView.frame = CGRectMake(0, 0, screenRect.size.width, contentHeight);
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

@end
