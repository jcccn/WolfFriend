//
//  PictureListViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SectionObject.h"
#import "PageObject.h"

@class ItemObject;
@class SectionObject;

@interface PictureListViewController : UITableViewController <SectionObjectDelegate, PageObjectDelegate> {
    SectionObject *sectionObject;
    PageObject *pageObject;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, retain) SectionObject *sectionObject;
@property (nonatomic, retain) PageObject *pageObject;

- (id)initWithSectionObject:(SectionObject *)aSectionObject;
- (void)startLoadItemList;

@end
