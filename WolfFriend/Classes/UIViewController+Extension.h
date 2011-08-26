//
//  UIViewController+Extension.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeManager.h"


@interface UIViewController (Extension)

- (void)setBrightness:(CGFloat)aBrightness;   //0-1.0
- (void)setBarBackroundColor:(UIColor *)aColor;

@end

@interface UITableViewController (Extension)

- (void)setBrightness:(CGFloat)aBrightness;
- (void)setBarBackroundColor:(UIColor *)aColor;


@end
