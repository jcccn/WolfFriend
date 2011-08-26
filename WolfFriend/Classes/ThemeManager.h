//
//  ThemeManager.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeObject : NSObject {
    CGFloat rColorUIText;
    CGFloat gColorUIText;
    CGFloat bColorUIText;
    CGFloat rColorUIBackground;
    CGFloat gColorUIBackground;
    CGFloat bColorUIBackground;
    CGFloat rColorUIFrame;
    CGFloat gColorUIFrame;
    CGFloat bColorUIFrame;
    CGFloat rColorReadText;
    CGFloat gColorReadText;
    CGFloat bColorReadText;
    CGFloat rColorReadBackground;
    CGFloat gColorReadBackground;
    CGFloat bColorReadBackground;
    CGFloat brightness;
    CGFloat fontSizeRead;
}
@property (nonatomic, assign) CGFloat rColorUIText;
@property (nonatomic, assign) CGFloat gColorUIText;
@property (nonatomic, assign) CGFloat bColorUIText;
@property (nonatomic, assign) CGFloat rColorUIBackground;
@property (nonatomic, assign) CGFloat gColorUIBackground;
@property (nonatomic, assign) CGFloat bColorUIBackground;
@property (nonatomic, assign) CGFloat rColorUIFrame;
@property (nonatomic, assign) CGFloat gColorUIFrame;
@property (nonatomic, assign) CGFloat bColorUIFrame;
@property (nonatomic, assign) CGFloat rColorReadText;
@property (nonatomic, assign) CGFloat gColorReadText;
@property (nonatomic, assign) CGFloat bColorReadText;
@property (nonatomic, assign) CGFloat rColorReadBackground;
@property (nonatomic, assign) CGFloat gColorReadBackground;
@property (nonatomic, assign) CGFloat bColorReadBackground;
@property (nonatomic, assign) CGFloat brightness;
@property (nonatomic, assign) CGFloat fontSizeRead;

@end

@interface ThemeManager : NSObject {
    NSString *themeFileName;
    ThemeObject *theme;
}
@property (nonatomic, retain) ThemeObject *theme;
@property (nonatomic, retain) UIColor *colorUIText;
@property (nonatomic, retain) UIColor *colorUIBackground;
@property (nonatomic, retain) UIColor *colorUIFrame;
@property (nonatomic, retain) UIColor *colorReadText;
@property (nonatomic, retain) UIColor *colorReadBackground;
@property (nonatomic, assign) CGFloat brightness;
@property (nonatomic, assign) CGFloat fontSizeRead;

+ (ThemeManager *)sharedManager;

- (UIColor *)uiColorWithWebColor:(NSString *)aWebColor;
- (NSString *)webColorWithUIColor:(UIColor *)aUIColor;

- (void)loadThemeWithFile:(NSString *)aFileName;
- (void)loadDefaultTheme;
- (void)loadUserTheme;
- (void)refreshThemeWithDictionary:(NSDictionary *)aThemeDict;


- (void)saveThemeWithFileName:(NSString *)aFileName;
- (void)saveTheme;


@end
