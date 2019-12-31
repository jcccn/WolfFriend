//
//  CategoryModel.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/11/13.
//  Copyright (c) 2013 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubCategoryModel.h"

@interface CategoryModel : NSObject

@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, copy) NSString *categoryTitle;
@property (nonatomic, strong) NSMutableArray *subCategories;

@end
