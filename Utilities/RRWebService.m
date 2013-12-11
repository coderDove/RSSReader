//
//  RRWebService.m
//  RSSReader
//
//  Created by Alexey on 16.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRWebService.h"

@implementation RRWebService {
    
}

- (NSData *)loadRSSFeedWithURLString:(NSString *)url {
    urlString = url;
    
    NSData* resultData = [self fetchDataWithURLString:urlString];
    return resultData;
}

- (NSData *)fetchDataWithURLString:(NSString *)url {
    NSError *error = nil;
    NSURLResponse* response = nil;
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData* resultData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    [self checkURLConnectionResponse:response];
    [self checkURLConnectionError:error];
    
    if (resultData.length == 0) {
        NSLog(@"!!! Nothing has been downloaded");
    }
     
    return resultData;
}

- (void)checkURLConnectionResponse:(NSURLResponse*)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = [httpResponse statusCode];
    
    if (code != 200) {
        logMessage = [NSString stringWithFormat:@"Error: loadRSSFeed: statusCode = %d", code];
        NSLog(@"%@", logMessage);
    }
}

- (void)checkURLConnectionError:(NSError*)error {
    if (error) {
        logMessage = [NSString stringWithFormat:@"Error: loadRSSFeed: error = %@", error.description];
        NSLog(@"%@", logMessage);
    }
}

@end

