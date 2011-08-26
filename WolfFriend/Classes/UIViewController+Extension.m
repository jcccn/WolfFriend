//
//  UIViewController+Extension.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "UIViewController+Extension.h"

#define TagLightMaskView    1000
#define TagTabBarBackground 1505
#define TagTabBarMaskView   1506
#define TagNavBarMaskView   1507


@implementation UIViewController (Extension)

- (void)setBrightness:(CGFloat)aBrightness {
    if (self.view) {
        UIView *lightMaskView = [self.view viewWithTag:TagLightMaskView];
        if ( ! lightMaskView) {
            CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
            UIView *lightMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, -1.0f * screenHeight, screenHeight,  3.0f *screenHeight)];
            lightMaskView.tag = TagLightMaskView;
            lightMaskView.backgroundColor = [UIColor blackColor];;
            lightMaskView.userInteractionEnabled = NO;
            [self.view addSubview:lightMaskView];
            [self.view bringSubviewToFront:lightMaskView];
            [lightMaskView release];
        }
        CGFloat brightness = aBrightness;
        if (brightness < 0) {
            brightness = 0;
        }
        else if(brightness > 1.0) {
            brightness = 1.0;
        }
//        lightMaskView.alpha = (100 - lightPercent) * 0.01;
        lightMaskView.alpha = 1.0f - brightness;
        
        UITabBarController *tabBarController = self.tabBarController;
        if (tabBarController) {
            UITabBar *tabBar = tabBarController.tabBar;
            UIView *lightTabBarMaskView = [tabBar viewWithTag:TagTabBarMaskView];
            if ( ! lightTabBarMaskView) {
                UIView *lightTabBarMaskView = [[UIView alloc] initWithFrame:tabBar.bounds];
                lightTabBarMaskView.tag = TagTabBarMaskView;
                lightTabBarMaskView.backgroundColor = [UIColor blackColor];;
                lightTabBarMaskView.userInteractionEnabled = NO;
                [tabBar addSubview:lightTabBarMaskView];
                [lightTabBarMaskView release];
            }
            [tabBar bringSubviewToFront:lightTabBarMaskView];
            lightTabBarMaskView.alpha = lightMaskView.alpha;
        }
//        UINavigationController *navigationController = self.navigationController;
//        if (navigationController) {
//            navigationController.navigationBar.alpha = lightMaskView.alpha;
//        }
        UINavigationController *navigationController = self.navigationController;
        if (navigationController) {
            UINavigationBar *navBar = navigationController.navigationBar;
            UIView *lightNavBarMaskView = [navBar viewWithTag:TagNavBarMaskView];
            if ( ! lightNavBarMaskView) {
                UIView *lightNavBarMaskView = [[UIView alloc] initWithFrame:navBar.bounds];
                lightNavBarMaskView.tag = TagNavBarMaskView;
                lightNavBarMaskView.backgroundColor = [UIColor blackColor];;
                lightNavBarMaskView.userInteractionEnabled = NO;
                [navBar addSubview:lightNavBarMaskView];
                [lightNavBarMaskView release];
            }
            [navBar bringSubviewToFront:lightNavBarMaskView];
            lightNavBarMaskView.alpha = lightMaskView.alpha;
        }
    }
}

- (void)setBarBackroundColor:(UIColor *)aColor {
    UITabBarController *tabBarController = self.tabBarController;
    if (tabBarController) {
        UITabBar *tabBar = tabBarController.tabBar;
        UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
        if ( ! tabBarBackgroundView) {
            tabBarBackgroundView = [[UIView alloc] initWithFrame:tabBar.bounds];
            tabBarBackgroundView.tag = TagTabBarBackground;
            [tabBar insertSubview:tabBarBackgroundView atIndex:0];
            [tabBarBackgroundView release];
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

- (void)setBrightness:(CGFloat)aBrightness {
    if (self.view) {
        if ( ! [self.view viewWithTag:TagLightMaskView]) {
            CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
            UIView *lightMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, -1.0f * screenHeight, screenHeight,  3.0f *screenHeight)];
            lightMaskView.tag = TagLightMaskView;
            lightMaskView.backgroundColor = [UIColor blackColor];
            lightMaskView.userInteractionEnabled = NO;
            [self.view addSubview:lightMaskView];
            [self.view bringSubviewToFront:lightMaskView];
            [lightMaskView release];
        }
        UIView *lightMaskView = [self.view viewWithTag:TagLightMaskView];
        CGFloat brightness = aBrightness;
        if (brightness < 0) {
            brightness = 0;
        }
        else if(brightness > 1.0) {
            brightness = 1.0;
        }
        lightMaskView.alpha = 1.0f - brightness;
        
        UITabBarController *tabBarController = self.tabBarController;
        if (tabBarController) {
            UITabBar *tabBar = tabBarController.tabBar;
            UIView *lightTabBarMaskView = [tabBar viewWithTag:TagTabBarMaskView];
            if ( ! lightTabBarMaskView) {
                UIView *lightTabBarMaskView = [[UIView alloc] initWithFrame:tabBar.bounds];
                lightTabBarMaskView.tag = TagTabBarMaskView;
                lightTabBarMaskView.backgroundColor = [UIColor blackColor];;
                lightTabBarMaskView.userInteractionEnabled = NO;
                [tabBar addSubview:lightTabBarMaskView];
                [lightTabBarMaskView release];
            }
            [tabBar bringSubviewToFront:lightTabBarMaskView];
            lightTabBarMaskView.alpha = lightMaskView.alpha;
        }
        
//        UINavigationController *navigationController = self.navigationController;
//        if (navigationController) {
//            navigationController.navigationBar.alpha = lightMaskView.alpha;
//        }
        UINavigationController *navigationController = self.navigationController;
        if (navigationController) {
            UINavigationBar *navBar = navigationController.navigationBar;
            UIView *lightNavBarMaskView = [navBar viewWithTag:TagNavBarMaskView];
            if ( ! lightNavBarMaskView) {
                UIView *lightNavBarMaskView = [[UIView alloc] initWithFrame:navBar.bounds];
                lightNavBarMaskView.tag = TagNavBarMaskView;
                lightNavBarMaskView.backgroundColor = [UIColor blackColor];;
                lightNavBarMaskView.userInteractionEnabled = NO;
                [navBar addSubview:lightNavBarMaskView];
                [lightNavBarMaskView release];
            }
            [navBar bringSubviewToFront:lightNavBarMaskView];
            lightNavBarMaskView.alpha = lightMaskView.alpha;
        }
    }
}

- (void)setBarBackroundColor:(UIColor *)aColor {
    UITabBarController *tabBarController = self.tabBarController;
    if (tabBarController) {
        UITabBar *tabBar = tabBarController.tabBar;
        UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
        if ( ! tabBarBackgroundView) {
            tabBarBackgroundView = [[UIView alloc] initWithFrame:tabBar.bounds];
            tabBarBackgroundView.tag = TagTabBarBackground;
            [tabBar insertSubview:tabBarBackgroundView atIndex:0];
            [tabBarBackgroundView release];
        }
        tabBarBackgroundView.backgroundColor = aColor;
    }
    UINavigationController *navigationController = self.navigationController;
    if (navigationController) {
        navigationController.navigationBar.tintColor = aColor;
    }
}


@end
