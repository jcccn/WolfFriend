//
//  UIViewController+Extension.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)setLightPercent:(NSInteger)aLightPercent;
- (void)setTabBarBackroundColor:(UIColor *)aColor;

@end

@interface UITableViewController (Extension)

- (void)setLightPercent:(NSInteger)aLightPercent;
- (void)setTabBarBackroundColor:(UIColor *)aColor;

@end
