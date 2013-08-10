//
//  PictureListViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Extension.h"
#import "SectionObject.h"
#import "PageObject.h"
#import "CategoryDataCenter.h"

@class ItemObject;
@class SectionObject;

@interface PictureListViewController : UITableViewController <SectionObjectDelegate, PageObjectDelegate, UIAlertViewDelegate> {
    SectionObject *sectionObject;
    PageObject *pageObject;
    UIActivityIndicatorView *activityIndicator;
}

@property (nonatomic, strong) SectionObject *sectionObject;
@property (nonatomic, strong) PageObject *pageObject;

@property (nonatomic, strong) SubCategoryModel *categoryModel;

- (id)initWithSectionObject:(SubCategoryModel *)categoryModel;
- (void)startLoadItemList;
- (void)showAlert;

- (void)resetUI:(id)arg;

@end
