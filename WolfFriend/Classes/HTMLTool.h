//
//  HTMLTool.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLTool : NSObject {
    
}

+ (NSInteger)parseSectionPageCountFromHTML:(NSString *)aHtml;
+ (NSMutableArray *)parseItemsArrayCountFromHTML:(NSString *)aHtml;
+ (NSString *)parseImageBodyFromHtml:(NSString *)aHtml;

@end
