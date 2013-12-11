//
//  RRBaseDataService.m
//  RSSReader
//
//  Created by Alexey on 20.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRBaseDataService.h"

@implementation RRBaseDataService

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
#pragma mark Should be overriden

- (void)loadRSSFeedWithCallback:(void (^)(NSArray *))callback {
}


@end
