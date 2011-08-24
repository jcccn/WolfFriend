//
//  ThemeManager.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *sharedThemeManager = nil;

@implementation ThemeManager

@synthesize backgroudColor;

+ (ThemeManager *)sharedManager {
    @synchronized(self) {
        if (sharedThemeManager == nil) {
            sharedThemeManager = [[ThemeManager alloc] init];
        }
    }
    return sharedThemeManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        // 从持久化存储中读取值
        backgroudColor = @"#FFFFFF";
    }
    
    return self;
}

- (void)setBackgroudColor:(NSString *)aBackgroudColor {
    backgroudColor = aBackgroudColor;
}

- (UIColor *)uiColorWithWebColor:(NSString *)aWebColor {
    return [UIColor whiteColor];
}
- (NSString *)webColorWithUIColor:(UIColor *)aUIColor {
    return @"#FFFFFF";
}

@end
#pragma mark- 主题数据对象

@implementation ThemeObject



@end