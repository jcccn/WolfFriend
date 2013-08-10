//
//  PictureCatalogManager.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "PictureCatalogManager.h"
#import "SectionObject.h"
#import "CommonModel.h"

static PictureCatalogManager *sharedPictureCatalogManager = nil;

@implementation PictureCatalogManager

@synthesize sectionList;

+ (PictureCatalogManager *)sharedManager {
    @synchronized(self) {
        if (sharedPictureCatalogManager == nil) {
            sharedPictureCatalogManager = [[PictureCatalogManager alloc] init];
        }
    }
    return sharedPictureCatalogManager;
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
    NSArray *titles = [NSArray arrayWithObjects:@"偷窥自拍", @"亚洲色图", @"欧美色图", @"明星裸照", @"清纯美女", @"美腿丝袜", @"乱伦熟女", @"情色另类", nil];
    NSArray *urls = [NSArray arrayWithObjects:@"Piclist2", @"Piclist1", @"Piclist3", @"Piclist6", @"Piclist5", @"Piclist7", @"Piclist8",@"Piclist9",  nil];
    for (int index = 0; index < 8; index++) {
        SectionObject *sectionObject = [[SectionObject alloc] initWithTitle:[titles objectAtIndex:index] urlString:[[[CommonModel sharedModel] baseUrlString] stringByAppendingFormat:@"/htm/%@",[urls objectAtIndex:index]]];
        [self.sectionList addObject:sectionObject];
    }
}

- (NSInteger)sectionCount {
    return [sectionList count];
}

- (NSInteger)pageCountForSection:(SectionObject *)aSection {
    return 0;
}


@end
