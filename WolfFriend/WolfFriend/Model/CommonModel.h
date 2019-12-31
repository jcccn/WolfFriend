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

@property (nonatomic, strong) NSString *baseUrlString;
@property (nonatomic, strong) NSString *defaultBaseUrlString;
@property (nonatomic, strong) NSString *autoBaseUrlString;
@property (nonatomic, strong) NSString *userBaseUrlString;    //用户输入的网址

@property (nonatomic, assign) NSInteger urlType;  //使用默认/自动/输入的网址

+ (CommonModel *)sharedModel;

@end
