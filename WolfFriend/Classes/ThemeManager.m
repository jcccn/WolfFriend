//
//  ThemeManager.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ThemeManager.h"

#define DEFAULT_VOID_COLOR ([UIColor whiteColor])

#define KeyRColorUIText         @"RColorUIText"
#define KeyGColorUIText         @"GColorUIText"
#define KeyBColorUIText         @"BColorUIText"
#define KeyRColorUIBackground   @"RColorUIBackground"
#define KeyGColorUIBackground   @"GColorUIBackground"
#define KeyBColorUIBackground   @"BColorUIBackground"
#define KeyRColorUIFrame        @"RColorUIFrame"
#define KeyGColorUIFrame        @"GColorUIFrame"
#define KeyBColorUIFrame        @"BColorUIFrame"
#define KeyRColorReadText       @"RColorReadText"
#define KeyGColorReadText       @"GColorReadText"
#define KeyBColorReadText       @"BColorReadText"
#define KeyRColorReadBackground @"RColorReadBackground"
#define KeyGColorReadBackground @"GColorReadBackground"
#define KeyBColorReadBackground @"BColorReadBackground"
#define KeyBrightness           @"Brightness"
#define KeyFontSizeRead         @"FontSizeRead"


static ThemeManager *sharedThemeManager = nil;

@implementation ThemeManager

@synthesize theme;
@synthesize colorUIText, colorReadBackground, colorUIFrame, colorReadText, colorUIBackground, brightness, fontSizeRead;

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
        self.theme = [[ThemeObject alloc] init];
        [self loadUserTheme];
    }
    
    return self;
}

- (void)dealloc {
    [self.theme release];
    [super dealloc];
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

- (void)loadThemeWithFile:(NSString *)aFileName {
    themeFileName = aFileName;
    NSFileManager *fileMgr = [NSFileManager defaultManager];   
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];  
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:aFileName];
    if ( ! [fileMgr fileExistsAtPath:filePath]) {
        [fileMgr copyItemAtPath:[[NSBundle mainBundle] pathForResource:@"default" ofType:@"plist"]
                         toPath:filePath
                          error:nil];
    }

    NSMutableDictionary *themeDict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    [self refreshThemeWithDictionary:themeDict];
}

- (void)loadDefaultTheme {
    [self loadThemeWithFile:@"default.plist"];
}

- (void)loadUserTheme {
    [self loadThemeWithFile:@"user.plist"];
}

- (void)refreshThemeWithDictionary:(NSDictionary *)themeDict {
    if (themeDict) {
        self.theme.rColorReadBackground = [[themeDict objectForKey:KeyRColorReadBackground] floatValue];
        self.theme.gColorReadBackground = [[themeDict objectForKey:KeyGColorReadBackground] floatValue];
        self.theme.bColorReadBackground = [[themeDict objectForKey:KeyBColorReadBackground] floatValue];
        self.theme.rColorReadText = [[themeDict objectForKey:KeyRColorReadText] floatValue];
        self.theme.gColorReadText = [[themeDict objectForKey:KeyGColorReadText] floatValue];
        self.theme.bColorReadText = [[themeDict objectForKey:KeyBColorReadText] floatValue];
        self.theme.rColorUIBackground = [[themeDict objectForKey:KeyRColorUIBackground] floatValue];
        self.theme.gColorUIBackground = [[themeDict objectForKey:KeyGColorUIBackground] floatValue];
        self.theme.bColorUIBackground = [[themeDict objectForKey:KeyBColorUIBackground] floatValue];
        self.theme.rColorUIFrame = [[themeDict objectForKey:KeyRColorUIFrame] floatValue];
        self.theme.gColorUIFrame = [[themeDict objectForKey:KeyGColorUIFrame] floatValue];
        self.theme.bColorUIFrame = [[themeDict objectForKey:KeyBColorUIFrame] floatValue];
        self.theme.rColorUIText = [[themeDict objectForKey:KeyRColorUIText] floatValue];
        self.theme.gColorUIText = [[themeDict objectForKey:KeyGColorUIText] floatValue];
        self.theme.bColorUIText = [[themeDict objectForKey:KeyBColorUIText] floatValue];
        self.theme.brightness = [[themeDict objectForKey:KeyBrightness] floatValue];
        self.theme.fontSizeRead = [[themeDict objectForKey:KeyFontSizeRead] floatValue];
    }
}


- (void)saveThemeWithFileName:(NSString *)aFileName {
    NSFileManager *fileMgr = [NSFileManager defaultManager];   
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];  
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:aFileName];
    if ([fileMgr fileExistsAtPath:filePath]) {
        [fileMgr removeItemAtPath:filePath error:nil];
    }

    NSMutableDictionary *themeDict = [NSMutableDictionary dictionaryWithCapacity:17];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.rColorReadBackground] forKey:KeyRColorReadBackground];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.gColorReadBackground] forKey:KeyGColorReadBackground];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.bColorReadBackground] forKey:KeyBColorReadBackground];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.rColorReadText] forKey:KeyRColorReadText];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.gColorReadText] forKey:KeyGColorReadText];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.bColorReadText] forKey:KeyBColorReadText];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.rColorUIBackground] forKey:KeyRColorUIBackground];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.gColorUIBackground] forKey:KeyGColorUIBackground];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.bColorUIBackground] forKey:KeyBColorUIBackground];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.rColorUIFrame] forKey:KeyRColorUIFrame];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.gColorUIFrame] forKey:KeyGColorUIFrame];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.bColorUIFrame] forKey:KeyBColorUIFrame];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.rColorUIText] forKey:KeyRColorUIText];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.gColorUIText] forKey:KeyGColorUIText];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.bColorUIText] forKey:KeyBColorUIText];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.brightness] forKey:KeyBrightness];
    [themeDict setObject:[NSNumber numberWithFloat:self.theme.fontSizeRead] forKey:KeyFontSizeRead];
    [themeDict writeToFile:filePath atomically:YES];
    
    [self refreshThemeWithDictionary:themeDict];
}

- (void)saveTheme {
    [self saveThemeWithFileName:@"user.plist"];
}

- (UIColor *)colorUIText {
    return [UIColor colorWithRed:theme.rColorUIText green:theme.gColorUIText blue:theme.bColorUIText alpha:1];
}
- (UIColor *)colorUIBackground {
    return [UIColor colorWithRed:theme.rColorUIBackground green:theme.gColorUIBackground blue:theme.bColorUIBackground alpha:1];
}
- (UIColor *)colorUIFrame {
    return [UIColor colorWithRed:theme.rColorUIFrame green:theme.rColorUIFrame blue:theme.bColorUIFrame alpha:1];
}
- (UIColor *)colorReadText {
    return [UIColor colorWithRed:theme.rColorReadText green:theme.gColorReadText blue:theme.bColorReadText alpha:1];
}
- (UIColor *)colorReadBackground {
    return [UIColor colorWithRed:theme.rColorReadBackground green:theme.rColorReadBackground blue:theme.bColorReadBackground alpha:1];
}
- (CGFloat)brightness {
    return theme.brightness;
}
- (CGFloat)fontSizeRead {
    return theme.fontSizeRead;
}

- (void)setColorUIText:(UIColor *)aColorUIText {
    const float* colors = CGColorGetComponents(aColorUIText.CGColor);
    theme.rColorUIText = colors[0];
    theme.gColorUIText = colors[1];
    theme.bColorUIText = colors[2];
}

- (void)setColorReadBackground:(UIColor *)aColorReadBackground {
    const float* colors = CGColorGetComponents(aColorReadBackground.CGColor);
    theme.rColorReadBackground = colors[0];
    theme.gColorReadBackground = colors[1];
    theme.bColorReadBackground = colors[2];
}

- (void)setColorUIFrame:(UIColor *)aColorUIFrame {
    const float* colors = CGColorGetComponents(aColorUIFrame.CGColor);
    theme.rColorUIFrame = colors[0];
    theme.gColorUIFrame = colors[1];
    theme.bColorUIFrame = colors[2];
}

- (void)setColorReadText:(UIColor *)aColorReadText {
    const float* colors = CGColorGetComponents(aColorReadText.CGColor);
    theme.rColorReadText = colors[0];
    theme.gColorReadText = colors[1];
    theme.bColorReadText = colors[2];
}

- (void)setColorUIBackground:(UIColor *)aColorUIBackground {
    const float* colors = CGColorGetComponents(aColorUIBackground.CGColor);
    theme.rColorUIBackground = colors[0];
    theme.gColorUIBackground = colors[1];
    theme.bColorUIBackground = colors[2];
}

- (void)setBrightness:(CGFloat)aBrightness {
    theme.brightness = aBrightness;
}

- (void)setFontSizeRead:(CGFloat)aFontSizeRead {
    theme.fontSizeRead = aFontSizeRead;
}


@end
#pragma mark- 主题数据对象

@implementation ThemeObject

@synthesize rColorUIText, gColorUIText, bColorUIText, rColorUIBackground, gColorUIBackground, bColorUIBackground, rColorUIFrame, gColorUIFrame, bColorUIFrame, rColorReadText, gColorReadText, bColorReadText, rColorReadBackground, gColorReadBackground, bColorReadBackground, brightness, fontSizeRead;



@end