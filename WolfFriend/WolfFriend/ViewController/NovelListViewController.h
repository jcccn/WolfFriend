//
//  NovelListViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/23/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Extension.h"
#import "CategoryDataCenter.h"

@interface NovelListViewController : UITableViewController <UIAlertViewDelegate> {

}

- (id)initWithSubCategory:(SubCategoryModel *)categoryModel;
- (void)showAlert;

- (void)resetUI:(id)arg;

@end
