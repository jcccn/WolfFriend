//
//  SectionObject.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "SectionObject.h"
#import "PageObject.h"

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
        currentPageObject = nil;
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
        currentPageObject = nil;
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

- (PageObject *)prePageObject {
    PageObject *aPageObject = nil;
    if (pageCount <= 0) {
        [self fetchPageCount];
    }
    if (pageCount > 0) {
        if (currentPageIndex > 1) {
            NSString *nextPageUrlString = @"/index.html";
            if (currentPageIndex > 2) {
                nextPageUrlString = [NSString stringWithFormat:@"/index_%d.html",pageCount-currentPageIndex];
            }
            aPageObject= [[PageObject alloc] initWithUrlString:[self.url stringByAppendingString:nextPageUrlString]];
            [currentPageObject release];
            currentPageObject = aPageObject;
            
            currentPageIndex --;
        }
        
    }
    return aPageObject;
}

- (PageObject *)currentPageObject {
    if ( ! currentPageObject) {
        currentPageObject = [self nextPageObject];
    }
    return currentPageObject;
}

- (PageObject *)nextPageObject {
    PageObject *aPageObject = nil;
    if (pageCount <= 0) {
        [self fetchPageCount];
    }
    if (pageCount > 0) {
        if (currentPageIndex < pageCount) {
            NSString *nextPageUrlString = @"/index.html";
            if (currentPageIndex > 0) {
                nextPageUrlString = [NSString stringWithFormat:@"/index_%d.html",pageCount-currentPageIndex];
            }
            aPageObject= [[PageObject alloc] initWithUrlString:[self.url stringByAppendingString:nextPageUrlString]];
            [currentPageObject release];
            currentPageObject = aPageObject;
            
            currentPageIndex ++;
        }
       
    }
    return aPageObject;
}

- (void)fetchPageCount {
    NSString *resourceText = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.url] encoding:NSUTF8StringEncoding error:NULL];
//    NSString *resourceText = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    pageCount = [HTMLTool parseSectionPageCountFromHTML:resourceText];
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
