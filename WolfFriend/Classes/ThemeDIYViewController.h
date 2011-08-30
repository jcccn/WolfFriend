//
//  ThemeDIYViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Extension.h"

@class ThemeManager;

@interface ThemeDIYViewController : UIViewController <UIAlertViewDelegate, UINavigationBarDelegate> {
    UIScrollView *scrollView;
    
    UILabel *colorHintLabel;
    UISegmentedControl *colorTypeSegmentedControl;
    UILabel *rColorLabel;
    UILabel *gColorLabel;
    UILabel *bColorLabel;
    UISlider *rSlider;
    UISlider *gSlider;
    UISlider *bSlider;
    
    UIColor *frameColor;
    
    UILabel *fontSizeHintLabel;
    UISlider *fontSizeSlider;
    UIColor *textBackgroundColor;
    UIColor *textFontColor;
    CGFloat textFontSize;
    UIWebView *textExampleWebView;
    
    UIButton *saveButton;
    UIButton *cancelButton;
}

@property (nonatomic, retain) UIColor *frameColor, *textBackgroundColor, *textFontColor;

- (void)changeTempColor:(UIColor *)aColor forTypeIndex:(NSInteger)anIndex;
- (void)changeTempFontSize:(CGFloat)floatFontSize;
- (void)changeTempReadBackgroundColor:(UIColor *)aBackgroundColor fontColor:(UIColor *)aFontColor fontSize:(CGFloat)aFontSize;
- (void)changeTempRead;

- (void)saveTheme;
- (void)cancel;

- (void)resetUI:(id)arg;

@end
