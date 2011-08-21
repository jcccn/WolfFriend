//
//  SectionObject.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "SectionObject.h"

@implementation SectionObject

@synthesize title, url, delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
//        pages = [[NSMutableArray alloc] init];
        pageCount = 0;
        currentPageIndex = 0;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)aTitle urlString:(NSString *)aUrlString {
    self = [super init];
    if (self) {
        self.title = aTitle;
        self.url = aUrlString;
//        pages = [[NSMutableArray alloc] init];
        pageCount = 0;
        currentPageIndex = 0;
    }
    return self;
}

//- (NSMutableArray *)pages {
//    return pages;
//}

- (NSInteger)pageCount {
    return pageCount;
}

- (NSInteger)currentPageIndex {
    return currentPageIndex;
}

- (void)refreshDataWithDeledate:(id<SectionObjectDelegate>)aDelegate {
    self.delegate = aDelegate;
    [[[[HTTPTool alloc] initWithDelegate:self] autorelease] startFetchDataWithURLString:self.url];
}

- (void)httpDataFetchedSuccess:(NSData *)theData {
    NSString *resourceText = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    pageCount = [HTMLTool parseSectionPageCountFromHTML:resourceText];
    [resourceText release];
    if (delegate) {
        [delegate sectionDataFectchedSuccess];
    }
}

- (void)httpDataFetchedFailed:(NSString *)theError {
    if (delegate) {
        [delegate sectionDataFectchedFailed];
    }
}

- (void)dealloc {
//    [pages release];
    [super dealloc];
}

@end
