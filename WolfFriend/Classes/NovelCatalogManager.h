//
//  NovelCatalogManager.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/23/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SectionObject;

@interface NovelCatalogManager : NSObject {
    NSMutableArray *sectionList;
    SectionObject *currentSection;
    NSInteger currentPageCount;
    NSInteger currentPageIndex;
}

@property (nonatomic, strong) NSMutableArray *sectionList;

+ (NovelCatalogManager *)sharedManager;
- (void)refresh;
- (NSInteger)sectionCount;
- (NSInteger)pageCountForSection:(SectionObject *)aSection;

@end
