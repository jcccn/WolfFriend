//
//  HTTPTool.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTTPToolDelegate

- (void)httpDataFetchedSuccess:(NSData *)theData;
- (void)httpDataFetchedFailed:(NSString *)theError;

@end


@interface HTTPTool : NSObject {
    id<HTTPToolDelegate> delegate;
    
    NSURLConnection *urlConnection;
    NSMutableData *bufferData;
}

@property (nonatomic, retain) id<HTTPToolDelegate> delegate;
@property (nonatomic, retain) NSMutableData *bufferData;

- (id)initWithDelegate:(id<HTTPToolDelegate>)aDelegate;
- (void)startFetchDataWithURLString:(NSString *)aString;
- (void)cancelConnection;


@end
