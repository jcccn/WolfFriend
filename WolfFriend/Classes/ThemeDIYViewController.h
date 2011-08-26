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

@interface ThemeDIYViewController : UIViewController <UIAlertViewDelegate> {
    UIScrollView *scrollView;
    
    UILabel *colorHintLabel;
    UISegmentedControl *colorTypeSegmentedControl;
    UILabel *rColorLabel;
    UILabel *gColorLabel;
    UILabel *bColorLabel;
    UISlider *rSlider;
    UISlider *gSlider;
    UISlider *bSlider;
    
    UILabel *brightnessHintLabel;
    UISlider *brightnessSlider;
    
    UILabel *fontSizeHintLabel;
    UISlider *fontSizeSlider;
    UILabel *textExampleLabel;
    
    
    UIButton *saveButton;
    UIButton *cancelButton;
}

- (void)changeTempColor:(UIColor *)aColor forTypeIndex:(NSInteger)anIndex;
- (void)changetempBrightness:(CGFloat)floatBrightness; 
- (void)changeTempFontSize:(CGFloat)floatFontSize;

- (void)saveTheme;
- (void)cancel;

- (void)resetUI:(id)arg;

@end
