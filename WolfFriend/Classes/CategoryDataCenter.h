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

+ (instancetype)sharedInstance;

- (void)loadAllImageCategories;

@end
