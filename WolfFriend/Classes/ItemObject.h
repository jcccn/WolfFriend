//
//  ItemObject.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemObject : NSObject {
    NSString *title;
    NSString *url;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;

@end
