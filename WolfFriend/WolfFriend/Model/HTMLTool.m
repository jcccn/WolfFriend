//
//  HTMLTool.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "HTMLTool.h"
#import "ThemeManager.h"
#import <hpple/TFHpple.h>

@implementation HTMLTool

+ (NSString *)parseImageBodyFromHtml:(NSString *)aHtml {
    NSArray *imageUrls = [self parseImagesFromHtml:aHtml];
    return [self generateImageBodyFromUrls:imageUrls];
}

+ (NSString *)generateImageBodyFromUrls:(NSArray *)imageUrls {
    if ( ! [imageUrls count]) {
        return @"";
    }
    
    NSMutableString *picturesString = [NSMutableString string];
    [picturesString appendString:@"<div>"];
    for (NSString *pictureUrl in imageUrls) {
        [picturesString appendFormat:@"<img src=\"%@\"/><br /><br />", pictureUrl];
    }
    [picturesString appendString:@"</div>"];
    
    return [self formatHTML:picturesString
              withFontColor:[[ThemeManager sharedManager] webColorWithUIColor:[[ThemeManager sharedManager] colorReadText]]
            backgroundColor:[[ThemeManager sharedManager] webColorWithUIColor:[[ThemeManager sharedManager] colorReadBackground]] fontSize:[[ThemeManager sharedManager] fontSizeRead]];
}

+ (NSArray *)parseImagesFromHtml:(NSString *)aHtml {
    NSMutableArray *imageUrls = [NSMutableArray array];
    
    if ( ! [aHtml length]) {
        return [NSArray array];
    }
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:[aHtml dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *picturesElements = [[[hpple searchWithXPathQuery:@"//div[@id='read_tpc']"] lastObject] childrenWithTagName:@"img"];
    
    if ( ! [picturesElements count]) {
        return [NSArray array];
    }
        
    for (TFHppleElement *pictureElement in picturesElements) {
        NSString *pictureUrl = [pictureElement objectForKey:@"src"];
        [imageUrls addObject:pictureUrl];
    }
    
    return [NSArray arrayWithArray:imageUrls];
}

+ (NSString *)parseNovelBodyFromHtml:(NSString *)aHtml {
    if ( ! [aHtml length]) {
        return @"";
    }
    
    TFHpple *hpple = [TFHpple hppleWithHTMLData:[aHtml dataUsingEncoding:NSUTF8StringEncoding]];
    TFHppleElement *bookElements = [[hpple searchWithXPathQuery:@"//div[@id='read_tpc']"] lastObject];
    
    
    NSString *bookString = [bookElements raw];
    
    if ( ! [bookString length]) {
        return @"";
    }
    
    return [self formatHTML:bookString
              withFontColor:[[ThemeManager sharedManager] webColorWithUIColor:[[ThemeManager sharedManager] colorReadText]]
            backgroundColor:[[ThemeManager sharedManager] webColorWithUIColor:[[ThemeManager sharedManager] colorReadBackground]] fontSize:[[ThemeManager sharedManager] fontSizeRead]];
}

+ (NSString *)formatHTML:(NSString *)aHtml withFontColor:(NSString *)aFontColor backgroundColor:(NSString *)aBackgroundColor fontSize:(CGFloat)aFontSize {
    return [NSString stringWithFormat:@"<html xml:lang=\"zh-CN\" xmlns=\"http://www.w3.org/1999/xhtml\"><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" /><title>WolfFriend</title><style type=\"text/css\">body {background-color:%@; font-family: \"%@\"; font-size: %d; color: %@;}</style></head><body>%@</body></html>", aBackgroundColor, @"Arial", (NSInteger)aFontSize, aFontColor, [HTMLTool flattenHTML:aHtml withLabel:@"font"]];
}

+ (NSString *)flattenHTML:(NSString *)aHtml withLabel:(NSString *)aLabel {
    if (aLabel && [aLabel length] > 0 && aHtml) {
        NSScanner *theScanner;
        NSString *text = nil;
        
        theScanner = [NSScanner scannerWithString:aHtml];
        
        while ([theScanner isAtEnd] == NO) {
            [theScanner scanUpToString:[NSString stringWithFormat:@"<%@",aLabel] intoString:NULL] ; 
            [theScanner scanUpToString:@">" intoString:&text] ;
            aHtml = [aHtml stringByReplacingOccurrencesOfString:
                     [ NSString stringWithFormat:@"%@>", text]
                                                     withString:@""];
            
        } // while //
    }
    
    return aHtml;
    
} 

@end
