//
//  PageObject.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLTool.h"
#import "HTTPTool.h"

@class SectionObject;

@protocol PageObjectDelegate

- (void)pageDataFectchedSuccess;
- (void)pageDataFectchedFailed;

@end

@interface PageObject : NSObject <HTTPToolDelegate> {
//    NSString *title;
//    NSInteger pageId;
    NSString *url;
    NSMutableArray *itemsArray;
    id<PageObjectDelegate> delegate;
    HTTPTool *httpTool;
}

//@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) id<PageObjectDelegate> delegate;

//- (id)initWithSection:(SectionObject *)aSection;
- (id)initWithUrlString:(NSString *)aUrlString;
- (NSMutableArray *)itemsArray;
- (void)refreshDataWithDeledate:(id<PageObjectDelegate>)aDelegate;
- (void)stopRefreshDataWithDeledate:(id<PageObjectDelegate>)aDelegate;
//- (NSString *)nextPageURL:

@end
