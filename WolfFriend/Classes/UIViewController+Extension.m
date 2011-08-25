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


@implementation UIViewController (Extension)

- (void)setLightPercent:(NSInteger)aLightPercent {
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
        NSInteger lightPercent = aLightPercent;
        if (aLightPercent < 0) {
            lightPercent = 0;
        }
        else if(aLightPercent > 100) {
            lightPercent = 100;
        }
//        lightMaskView.alpha = (100 - lightPercent) * 0.01;
        lightMaskView.alpha = 1.0f - 0.01f*lightPercent;
        
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
    }
}

- (void)setTabBarBackroundColor:(UIColor *)aColor {
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
}

@end


@implementation UITableViewController (Extension)

- (void)setLightPercent:(NSInteger)aLightPercent {
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
        NSInteger lightPercent = aLightPercent;
        if (aLightPercent < 0) {
            lightPercent = 0;
        }
        else if(aLightPercent > 100) {
            lightPercent = 100;
        }
        lightMaskView.alpha = 1.0f - 0.01f*lightPercent;
        
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
    }
}

- (void)setTabBarBackroundColor:(UIColor *)aColor {
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
}

@end
