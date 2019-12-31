//
//  CategoryDataCenter.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/11/13.
//  Copyright (c) 2013 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"

@interface CategoryDataCenter : NSObject

@property (nonatomic, strong) NSMutableArray *imageCategories;
@property (nonatomic, strong) NSMutableArray *bookCategories;

+ (instancetype)sharedInstance;

- (void)loadAllImageCategories;

- (void)parseImageCategory:(SubCategoryModel *)category atPage:(NSInteger)pageIndex;

- (void)loadAllBookCategories;

- (void)parseBookCategory:(SubCategoryModel *)category atPage:(NSInteger)pageIndex;

@end
