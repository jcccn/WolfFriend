//
//  ThemeManager.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ThemeObject : NSObject

@property (nonatomic, assign) CGFloat rColorUIFrame;
@property (nonatomic, assign) CGFloat gColorUIFrame;
@property (nonatomic, assign) CGFloat bColorUIFrame;
@property (nonatomic, assign) CGFloat rColorReadText;
@property (nonatomic, assign) CGFloat gColorReadText;
@property (nonatomic, assign) CGFloat bColorReadText;
@property (nonatomic, assign) CGFloat rColorReadBackground;
@property (nonatomic, assign) CGFloat gColorReadBackground;
@property (nonatomic, assign) CGFloat bColorReadBackground;
@property (nonatomic, assign) CGFloat fontSizeRead;

@end

@interface ThemeManager : NSObject {
    NSString *themeFileName;
    ThemeObject *theme;
}
@property (nonatomic, strong) ThemeObject *theme;
@property (nonatomic, strong) UIColor *colorUIFrame;
@property (nonatomic, strong) UIColor *colorReadText;
@property (nonatomic, strong) UIColor *colorReadBackground;
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
