//
//  NovelCatalogManager.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/23/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "NovelCatalogManager.h"
#import "SectionObject.h"

static NovelCatalogManager *sharedNovelCatalogManager = nil;

@implementation NovelCatalogManager

@synthesize sectionList;

+ (NovelCatalogManager *)sharedManager {
    @synchronized(self) {
        if (sharedNovelCatalogManager == nil) {
            sharedNovelCatalogManager = [[NovelCatalogManager alloc] init];
        }
    }
    return sharedNovelCatalogManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        sectionList = [[NSMutableArray alloc] init];
        
        
        [self refresh];
    }
    
    return self;
}

- (void)refresh {
    NSArray *titles = [NSArray arrayWithObjects:@"激情文学", @"乱伦文学", @"淫色人妻", @"武侠古典", @"迷情校园", @"黄色笑话", @"意淫强奸", @"交通色狼", nil];
    NSArray *urls = [NSArray arrayWithObjects:@"Novellist1", @"Novellist2", @"Novellist3", @"Novellist6", @"Novellist4", @"Novellist7", @"Novellist5",@"Novellist8",  nil];
    for (int index = 0; index < 8; index++) {
        SectionObject *sectionObject = [[SectionObject alloc] initWithTitle:[titles objectAtIndex:index] urlString:[@"http://www.34eee.com/htm/" stringByAppendingString:[urls objectAtIndex:index]]];
        [self.sectionList addObject:sectionObject];
        [sectionObject release];
    }
}

- (NSInteger)sectionCount {
    return [sectionList count];
}

- (NSInteger)pageCountForSection:(SectionObject *)aSection {
    return 0;
}

- (void)dealloc {
    [sectionList release];
    [super dealloc];
}

@end
