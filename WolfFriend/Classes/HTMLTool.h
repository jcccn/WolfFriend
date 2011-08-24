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
+ (NSString *)parseNovelBodyFromHtml:(NSString *)aHtml;

+ (NSString *)flattenHTML:(NSString *)aHtml withLabel:(NSString *)aLabel;
+ (NSString *)formatHTML:(NSString *)aHtml withFontColor:(NSString *)aFontColor;    //添加更多参数

@end
