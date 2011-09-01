//
//  CommonModel.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 9/1/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonModel : NSObject {
    NSString *baseUrlString;
    NSString *defaultBaseUrlString;
    NSString *autoBaseUrlString;
    NSString *userBaseUrlString;    //用户输入的网址
    
    NSInteger urlType;  //使用默认/自动/输入的网址
}

@property (nonatomic, retain) NSString *baseUrlString;
@property (nonatomic, retain) NSString *defaultBaseUrlString;
@property (nonatomic, retain) NSString *autoBaseUrlString;
@property (nonatomic, retain) NSString *userBaseUrlString;    //用户输入的网址

@property (nonatomic, assign) NSInteger urlType;  //使用默认/自动/输入的网址

+ (CommonModel *)sharedModel;

@end
