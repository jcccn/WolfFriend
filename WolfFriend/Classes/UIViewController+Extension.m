//
//  UIViewController+Extension.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)


- (void)setBarBackroundColor:(UIColor *)aColor {
    UITabBarController *tabBarController = self.tabBarController;
    if (tabBarController) {
        UITabBar *tabBar = tabBarController.tabBar;
        UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
        if ( ! tabBarBackgroundView) {
            tabBarBackgroundView = [[UIView alloc] initWithFrame:tabBar.bounds];
            tabBarBackgroundView.tag = TagTabBarBackground;
            [tabBar insertSubview:tabBarBackgroundView atIndex:0];
        }
        tabBarBackgroundView.backgroundColor = aColor;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController) {
        navigationController.navigationBar.tintColor = aColor;
    }
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    BOOL shouldAuto = NO;
//    switch (getIntPref(KeyScreenOrientation, 0)) {
//        case 0: {
//            shouldAuto = UIInterfaceOrientationIsPortrait(interfaceOrientation);;
//        }
//            break;
//            
//        case 1: {
//            shouldAuto = YES;
//        }
//            break;
//        case 2: {
//            shouldAuto = UIInterfaceOrientationIsLandscape(interfaceOrientation);
//        }
//            break;
//        default:
//            break;
//    }
//    return shouldAuto;
//}


@end


@implementation UITableViewController (Extension)


- (void)setBarBackroundColor:(UIColor *)aColor {
    UITabBarController *tabBarController = self.tabBarController;
    if (tabBarController) {
        UITabBar *tabBar = tabBarController.tabBar;
        UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
        if ( ! tabBarBackgroundView) {
            tabBarBackgroundView = [[UIView alloc] initWithFrame:tabBar.bounds];
            tabBarBackgroundView.tag = TagTabBarBackground;
            [tabBar insertSubview:tabBarBackgroundView atIndex:0];
        }
        tabBarBackgroundView.backgroundColor = aColor;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController) {
        navigationController.navigationBar.tintColor = aColor;
    }
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
}

@end
