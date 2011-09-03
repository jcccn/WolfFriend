//
//  DisclaimerViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "DisclaimerViewController.h"

@implementation DisclaimerViewController

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
    self.title = @"免责声明";
    self.view.backgroundColor = self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableBackground.png"]];
    if ( ! disclaimerLabel) {
        disclaimerLabel = [[UILabel alloc] initWithFrame:CGRectOffset(self.view.bounds, 0, -50)];
        disclaimerLabel.numberOfLines = 0;
        disclaimerLabel.textAlignment = UITextAlignmentCenter;
        disclaimerLabel.backgroundColor = [UIColor clearColor];
        disclaimerLabel.textColor = [UIColor blueColor];
        disclaimerLabel.text = @"本软件仅供个人开发技术探讨，通过各种途径获取和使用本软件及其衍生品，与本软件的开发者无关！";
        [self.view addSubview:disclaimerLabel];
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
    [self willAnimateRotationToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:0];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    BOOL shouldAuto = NO;
    switch (getIntPref(KeyScreenOrientation, 0)) {
        case 0: {
            shouldAuto = UIInterfaceOrientationIsPortrait(interfaceOrientation);
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
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        //竖屏
        CGFloat contentHeight = screenRect.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
        disclaimerLabel.frame = CGRectMake(0, 0, screenRect.size.width, contentHeight - 50);
    }
    else {
        //横屏
        CGFloat contentHeight = screenRect.size.width - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
        disclaimerLabel.frame = CGRectMake(0, 0, screenRect.size.height, contentHeight - 30);
    }
    UITabBarController *tabBarController = self.tabBarController;
    UITabBar *tabBar = tabBarController.tabBar;
    UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
    if (tabBarBackgroundView) {
        tabBarBackgroundView.frame = tabBar.bounds;
    }
}

@end
