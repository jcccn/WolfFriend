//
//  CommonModel.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 9/1/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "CommonModel.h"
#import "Helper.h"

static CommonModel *sharedModel = nil;

@implementation CommonModel

@synthesize baseUrlString, defaultBaseUrlString, autoBaseUrlString, userBaseUrlString, urlType;

+ (CommonModel *)sharedModel{
    @synchronized(self) {
        if (sharedModel == nil) {
            sharedModel = [[CommonModel alloc] init];
        }
    }
    return sharedModel;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.defaultBaseUrlString = @"http://www.34eee.com";
        self.autoBaseUrlString = @"http://www.34eee.com";
        self.userBaseUrlString = [NSString stringWithFormat:@"%@.%@.%@",
                                  getPref(@"UserUrlPart1", @"www"),
                                  getPref(@"UserUrlPart2", @"34eee"),
                                  getPref(@"UserUrlPart3", @"com")];
        self.urlType = getIntPref(@"UrlType", 0);
    }
    
    return self;
}

- (NSString *)baseUrlString {
    NSString *theBaseUrl = @"";
    switch (urlType) {
        case 0: {
            theBaseUrl = defaultBaseUrlString;
        }
            break;
        case 1: {
            theBaseUrl = autoBaseUrlString;
        }
            break;
        case 2: {
            theBaseUrl = userBaseUrlString;
            if ([theBaseUrl length] == 0) {
                theBaseUrl = defaultBaseUrlString;
            }
        }
            break;
        default:
            break;
    }
    return theBaseUrl;
}

@end
