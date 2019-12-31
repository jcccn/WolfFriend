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

@end
