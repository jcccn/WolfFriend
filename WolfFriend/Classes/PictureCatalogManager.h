//
//  PictureCatalogManager.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionObject.h"

@interface PictureCatalogManager : NSObject {
    NSMutableArray *sectionList;
    SectionObject *currentSection;
    NSInteger currentPageCount;
    NSInteger currentPageIndex;
}

@property (nonatomic, retain) NSMutableArray *sectionList;

+ (PictureCatalogManager *)sharedManager;
- (void)refresh;
- (NSInteger)sectionCount;
- (NSInteger)pageCountForSection:(SectionObject *)aSection;

@end
