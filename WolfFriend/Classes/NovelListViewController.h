//
//  NovelListViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/23/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SectionObject.h"
#import "PageObject.h"

@class ItemObject;
@class SectionObject;

@interface NovelListViewController : UITableViewController <SectionObjectDelegate, PageObjectDelegate, UIAlertViewDelegate> {
    SectionObject *sectionObject;
    PageObject *pageObject;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) SectionObject *sectionObject;
@property (nonatomic, retain) PageObject *pageObject;

- (id)initWithSectionObject:(SectionObject *)aSectionObject;
- (void)startLoadItemList;
- (void)showAlert;

@end
