//
//  RRDataService.m
//  RSSReader
//
//  Created by Alexey on 16.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRDataService.h"
#import "RRWebService.h"
#import "RRXMLDataParser.h"


@implementation RRDataService
//+ (id) sharedInstance {
//    return [super sharedInstance];
//}

static id sharedInstance;

#pragma mark -
#pragma mark Init
- (id)init {
    self = [super init];
    if(self){
        _dataProcessingQueue = dispatch_queue_create("com.rssReader.dispatchQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (id) sharedInstance {
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
            
        }
    });
    
    return sharedInstance;
}


+ (id) copyWithZone: (NSZone *) zone {
    return self;
}


+ (id) allocWithZone: (NSZone *) zone {
    if (sharedInstance != nil) {
        return [sharedInstance retain];
    }
    else {
        return [super allocWithZone: zone];
    }
}


- (id) retain {
    return self;
}


- (oneway void) release {
    
}

- (id) autorelease {
    return self;
}

- (NSUInteger) retainCount {
    return NSUIntegerMax;
}

- (void) dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark RSS

- (void)loadRSSFeedWithCallback:(void (^)(NSArray *))callback {
    dispatch_async(_dataProcessingQueue, ^(){
        NSArray *parsedDataArray;
        RRWebService *webService = [[RRWebService alloc] init];
        
        NSData *xmlData = [webService loadRSSFeedWithURLString:@"http://feeds.bbci.co.uk/news/rss.xml"];
        [webService release];
        if (xmlData.length > 0) {
            RRXMLDataParser *xmlParser = [[RRXMLDataParser alloc] init];
            parsedDataArray = [xmlParser parseXml:xmlData];
            [xmlParser release];
        
            if(callback) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    callback(parsedDataArray);
                });
            }
        }
    });
}

@end
