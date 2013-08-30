//
//  WolfFriendAppDelegate.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "WolfFriendAppDelegate.h"
#import "PictureSectionListViewController.h"
#import "PictureBrowserViewController.h"
#import "NovelSectionListViewController.h"
#import "NovelBrowserViewController.h"
#import "ToolViewController.h"
#import <KKPasscodeLock/KKPasscodeLock.h>

#define TagTabBarItemPicture    10001
#define TagTabBarItemNovel      10002
#define TagTabBarItemTool       10003

@interface WolfFriendAppDelegate () <KKPasscodeViewControllerDelegate>

@property (nonatomic, strong) KKPasscodeViewController *passcodeViewController;
@property (nonatomic, strong) UINavigationController *passcodeNavigationController;

- (void)showPasscodeViewWhenNeeded;
- (void)createPasscodeViewWhenNeeded;

@end

@implementation WolfFriendAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[KKPasscodeLock sharedLock] setDefaultSettings];
    [KKPasscodeLock sharedLock].eraseOption = NO;
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    UINavigationController *pictureNavigationController = [[UINavigationController alloc] initWithRootViewController:[[PictureSectionListViewController alloc] init]];
    pictureNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"美图浏览" image:[UIImage imageNamed:@"IconPicture.png"] tag:TagTabBarItemPicture];
    
    UINavigationController *novelNavigationController = [[UINavigationController alloc] initWithRootViewController:[[NovelSectionListViewController alloc] init]];
    novelNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"小说阅读" image:[UIImage imageNamed:@"IconNovel.png"] tag:TagTabBarItemNovel];
    
    UINavigationController *toolNavigationController = [[UINavigationController alloc] initWithRootViewController:[[ToolViewController alloc] initWithStyle:UITableViewStyleGrouped]];
    toolNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"工具箱" image:[UIImage imageNamed:@"IconTool.png"] tag:TagTabBarItemTool];
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:pictureNavigationController, novelNavigationController, toolNavigationController, nil];
    
    [self showPasscodeViewWhenNeeded];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [self showPasscodeViewWhenNeeded];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    [self showPasscodeViewWhenNeeded];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - KKPasscodeViewControllerDelegate

- (void)didPasscodeEnteredCorrectly:(KKPasscodeViewController*)viewController {
    self.window.rootViewController = self.tabBarController;
}

- (void)didPasscodeEnteredIncorrectly:(KKPasscodeViewController*)viewController {
    
}

- (void)shouldLockApplication:(KKPasscodeViewController*)viewController {
    
}

- (void)shouldEraseApplicationData:(KKPasscodeViewController*)viewController {
    
}

- (void)didSettingsChanged:(KKPasscodeViewController*)viewController {
    
}

- (void)showPasscodeViewWhenNeeded {
    [self createPasscodeViewWhenNeeded];
    
    if ([[KKPasscodeLock sharedLock] isPasscodeRequired]) {
        self.window.rootViewController = self.passcodeNavigationController;
    }
    else {
        self.window.rootViewController = self.tabBarController;
    }
}

- (void)createPasscodeViewWhenNeeded {
    if ( ! (self.passcodeViewController && self.passcodeNavigationController)) {
        self.passcodeViewController = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
        self.passcodeViewController.mode = KKPasscodeModeEnter;
        self.passcodeViewController.delegate = self;
        
        self.passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.passcodeViewController];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            self.passcodeNavigationController.modalPresentationStyle = UIModalPresentationFormSheet;
            self.passcodeNavigationController.navigationBar.barStyle = UIBarStyleBlack;
            self.passcodeNavigationController.navigationBar.opaque = NO;
        }
    }
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
