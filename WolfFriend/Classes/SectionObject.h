//
//  SectionObject.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLTool.h"
#import "HTTPTool.h"

@protocol SectionObjectDelegate

- (void)sectionDataFectchedSuccess;
- (void)sectionDataFectchedFailed;

@end

@interface SectionObject : NSObject <HTTPToolDelegate> {
    NSString *title;
    NSString *url;
//    NSMutableArray *pages;
    NSInteger pageCount;
    NSInteger currentPageIndex;
    
    id<SectionObjectDelegate> delegate;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) id<SectionObjectDelegate> delegate;

- (id)initWithTitle:(NSString *)aTitle urlString:(NSString *)aUrlString;
//- (NSMutableArray *)pages;
- (NSInteger)pageCount;
- (NSInteger)currentPageIndex;
- (void)refreshDataWithDeledate:(id<SectionObjectDelegate>)aDelegate;


@end
