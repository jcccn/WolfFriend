//
//  PageObject.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "PageObject.h"
#import "SectionObject.h"

@implementation PageObject

@synthesize url, delegate;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        itemsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithUrlString:(NSString *)aUrlString {
    self = [super init];
    if (self) {
        self.url = aUrlString;
        itemsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)httpDataFetchedSuccess:(NSData *)theData {
    NSString *resourceText = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
    [itemsArray removeAllObjects];
    [itemsArray addObjectsFromArray:[HTMLTool parseItemsArrayCountFromHTML:resourceText]];
    [resourceText release];
    if (self.delegate) {
        [self.delegate pageDataFectchedSuccess];
    }
}

- (void)httpDataFetchedFailed:(NSString *)theError {
    if (self.delegate) {
        [self.delegate pageDataFectchedFailed];
    }
}

- (void)refreshDataWithDeledate:(id<PageObjectDelegate>)aDelegate {
    self.delegate = aDelegate;
    [[[[HTTPTool alloc] initWithDelegate:self] autorelease] startFetchDataWithURLString:self.url];
}

- (NSMutableArray *)itemsArray {
    return itemsArray;
}

- (void)dealloc {
    [super dealloc];
}

@end
