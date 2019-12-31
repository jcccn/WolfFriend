//
//  ArticleModel.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/11/13.
//  Copyright (c) 2013 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic, assign) NSInteger articleId;
@property (nonatomic, copy) NSString *articleTitle;
@property (nonatomic, copy) NSString *articleUrl;

@property (nonatomic, assign) NSInteger articleType;

@end
