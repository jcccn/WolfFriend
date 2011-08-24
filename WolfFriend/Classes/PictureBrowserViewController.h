//
//  PictureBrowserViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SectionObject;
@class ItemObject;

@interface PictureBrowserViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> {
    
    UIWebView *webView;
    
    SectionObject *sectionObject;
    ItemObject *itemObject;
    UIActivityIndicatorView *activityIndicator;

}
@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) SectionObject *sectionObject;
@property (nonatomic, retain) ItemObject *itemObject;

- (id)initWithSection:(SectionObject *)section item:(ItemObject *)item;
- (void)startLoadWebPage;
- (void)showAlert;

@end
