//
//  ThemeManager.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ThemeManager.h"

#define DEFAULT_VOID_COLOR ([UIColor whiteColor])


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
    NSString *cString = [[aWebColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return DEFAULT_VOID_COLOR;
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return DEFAULT_VOID_COLOR;
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
- (NSString *)webColorWithUIColor:(UIColor *)aUIColor {
    const float* colors = CGColorGetComponents(aUIColor.CGColor);
    NSInteger rInt = (NSInteger)(255 * colors[0]);
    NSInteger gInt = (NSInteger)(255 * colors[1]);
    NSInteger bInt = (NSInteger)(255 * colors[2]);
    return [NSString stringWithFormat:@"#%02X%02X%02X", rInt, gInt, bInt];
}

@end
#pragma mark- 主题数据对象

@implementation ThemeObject



@end