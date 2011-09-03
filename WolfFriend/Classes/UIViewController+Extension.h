//
//  UIViewController+Extension.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"

#import "Helper.h"
#define KeyScreenOrientation    @"ScreenOrientation"
#define TagTabBarBackground 1505



@interface UIViewController (Extension)

- (void)setBarBackroundColor:(UIColor *)aColor;

@end

@interface UITableViewController (Extension)

- (void)setBarBackroundColor:(UIColor *)aColor;


@end
