//
//  CategoryDataCenter.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/11/13.
//  Copyright (c) 2013 SenseForce. All rights reserved.
//

#import "CategoryDataCenter.h"
#import <BlocksKit/NSURLConnection+BlocksKit.h>
#import <hpple/TFHpple.h>

@implementation CategoryDataCenter

+ (instancetype)sharedInstance {
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init {
    self = [super init];
    if (self) {
        self.imageCategories = [NSMutableArray array];
    }
    return self;
}

- (void)loadAllImageCategories {
    NSString *indexUrl = @"http://cnsina8.com/index.php";
    __weak CategoryDataCenter *blockSelf = self;
    [NSURLConnection startConnectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:indexUrl]]
                                 successHandler:^(NSURLConnection *urlConnection, NSURLResponse *urlResponse, NSData *data) {
                                     
                                     [blockSelf.imageCategories removeAllObjects];
                                     
                                     TFHpple *doc = [TFHpple hppleWithData:data encoding:@"utf-8" isXML:NO];
                                     
                                     //图片
                                     NSArray *columnIds = @[@"1", @"144", @"145", @"146"];
                                     NSMutableString *columnXpath = [NSMutableString stringWithString:@"//div[@class='t' and ("];
                                     for (NSString *columnId in columnIds) {
                                         [columnXpath appendFormat:@"@id='t_%@'", columnId];
                                         if ([columnIds indexOfObject:columnId] != [columnIds count] - 1) {
                                             [columnXpath appendString:@" or "];
                                         }
                                     }
                                     [columnXpath appendString:@")]"];
//                                     columnXpath = @"//div[@class='t' and (@id='t_1' or @id='t_144' or @id='t_145' or @id='t_146')]";
                                     BOOL flag = YES;
                                     NSArray *columnElements = [doc searchWithXPathQuery:columnXpath];
                                     for (TFHppleElement *columnElement in columnElements) {
                                         CategoryModel *categoryModel = [[CategoryModel alloc] init];
                                         [self.imageCategories addObject:categoryModel];
                                         categoryModel.categoryId = [[[columnElement objectForKey:@"id"] stringByReplacingOccurrencesOfString:@"t_" withString:@""] integerValue];
                                         categoryModel.subCategories = [NSMutableArray array];
                                         
                                         TFHpple *columnTitleDoc = [TFHpple hppleWithHTMLData:[[columnElement raw] dataUsingEncoding:NSUTF8StringEncoding]];
                                         TFHppleElement *columnTitleElement = [[[columnTitleDoc searchWithXPathQuery:@"//h2"] lastObject] firstChildWithTagName:@"a"];
                                         NSString *columnTitle = [[columnTitleElement firstTextChild] content];
                                         categoryModel.categoryTitle = columnTitle;
                                         NSLog(@"版块:%@:%@", [columnElement objectForKey:@"id"], columnTitle);
                                         
                                         TFHppleElement *subColumn = [[[columnElement firstChildWithTagName:@"table"] childrenWithTagName:@"tbody"] lastObject];
                                         TFHpple *subDoc = [TFHpple hppleWithHTMLData:[[subColumn raw] dataUsingEncoding:NSUTF8StringEncoding]];
                                         NSArray *subColumnElements = [subDoc searchWithXPathQuery:@"//a[@class='fnamecolor b']"];
                                         
                                         for (TFHppleElement *subColumnElement in subColumnElements) {
                                             NSLog(@"\t子版块:%@:%@", [subColumnElement objectForKey:@"id"], [[subColumnElement firstTextChild] content]);
                                             
                                             SubCategoryModel *subCategoryModel = [[SubCategoryModel alloc] init];
                                             subCategoryModel.categoryId = [[[subColumnElement objectForKey:@"id"] stringByReplacingOccurrencesOfString:@"fn_" withString:@""] integerValue];
                                             subCategoryModel.categoryTitle = [[subColumnElement firstTextChild] content];
                                             [categoryModel.subCategories addObject:subCategoryModel];
                                         }
                                         
                                         if (flag) {
                                             
                                         }
                                         flag = NO;
                                         
                                     }
                                     
                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"DataCenterUpdated" object:blockSelf];
                                 }
                                 failureHandler:^(NSURLConnection *urlConnection, NSError *error) {
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"DataCenterUpdated" object:blockSelf];
                                 }];
}

- (void)parseImageCategory:(SubCategoryModel *)category atPage:(NSInteger)pageIndex {
    NSString *categoryUrl = [NSString stringWithFormat:@"http://cnsina8.com/thread-htm-fid-%d-page-%d.html", category.categoryId, pageIndex];
    __weak CategoryDataCenter *blockSelf = self;
    [NSURLConnection startConnectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:categoryUrl]]
                                 successHandler:^(NSURLConnection *urlConnection, NSURLResponse *urlResponse, NSData *data) {
                                     TFHpple *doc = [TFHpple hppleWithData:data encoding:@"utf-8" isXML:NO];
                                     NSArray *objects = [doc searchWithXPathQuery:@"//tr[@class='tr3 t_one']"];
                                     NSMutableArray *articles = [NSMutableArray arrayWithCapacity:[objects count]];
                                     for (TFHppleElement *object in objects) {
                                         TFHpple *subDoc = [TFHpple hppleWithHTMLData:[[object raw] dataUsingEncoding:NSUTF8StringEncoding]];
                                         TFHppleElement *articleElement = [[subDoc searchWithXPathQuery:@"//a[@class='subject']"] lastObject];
                                         
                                         TFHppleElement *titleElement = [articleElement firstChildWithTagName:@"b"];
                                         if ( ! titleElement) {
                                             titleElement = articleElement;
                                         }
                                         
                                         titleElement = [titleElement firstChildWithTagName:@"font"];
                                         if ( ! titleElement) {
                                             titleElement = articleElement;
                                         }
                                         
                                         NSString *title = [[titleElement firstTextChild] content];
                                         
                                         if (title) {
                                             ArticleModel *articleModel = [[ArticleModel alloc] init];
                                             articleModel.articleId = [[[articleElement objectForKey:@"id"] stringByReplacingOccurrencesOfString:@"a_ajax_" withString:@""] integerValue];
                                             articleModel.articleTitle = title;
                                             articleModel.articleUrl = [articleElement objectForKey:@"href"];
                                             [articles addObject:articleModel];
                                         }
                                         else {
                                             
                                         }
                                     }
                                     
                                     if ([articles count]) {
                                         category.articles = articles;
                                     }
                                     
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"CategoryDataUpdated" object:blockSelf userInfo:@{@"success": @([articles count])}];
                                 }
                                 failureHandler:^(NSURLConnection *urlConnection, NSError *error) {
                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"CategoryDataUpdated" object:blockSelf userInfo:@{@"success": @(NO)}];
                                 }];
}

@end
