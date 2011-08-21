//
//  HTTPTool.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "HTTPTool.h"

@implementation HTTPTool

@synthesize delegate;
@synthesize bufferData;

- (id)initWithDelegate:(id<HTTPToolDelegate>)aDelegate
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.delegate = aDelegate;
        
    }
    
    return self;
}


- (void)startFetchDataWithURLString:(NSString *)aString {
    NSLog(@"aString:%@",aString);
    self.bufferData = [NSMutableData data];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:aString]];
    urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -
#pragma NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.bufferData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.bufferData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.delegate) {
        [self.delegate httpDataFetchedSuccess:bufferData];
        self.bufferData = nil;
        urlConnection = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (self.delegate) {
        [self.delegate httpDataFetchedFailed:[error description]];
        self.bufferData = nil;
        urlConnection = nil;
    }
}

- (void)dealloc {
    if (bufferData) {
        [bufferData release];
    }
    [super dealloc];
}

@end
