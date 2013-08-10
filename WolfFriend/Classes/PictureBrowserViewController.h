//
//  PictureBrowserViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Extension.h"
@class SectionObject;
@class ItemObject;

@interface PictureBrowserViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
    
    UIWebView *webView;
    
    SectionObject *sectionObject;
    ItemObject *itemObject;
    UIActivityIndicatorView *activityIndicator;

}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) SectionObject *sectionObject;
@property (nonatomic, strong) ItemObject *itemObject;

- (id)initWithSection:(SectionObject *)section item:(ItemObject *)item;
- (void)startLoadWebPage;
- (void)showAlert;

- (void)resetUI:(id)arg;

@end
