//
//  RRBaseDataService.h
//  RSSReader
//
//  Created by Alexey on 20.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RRBaseDataService : NSObject

@property (readonly, nonatomic, assign) dispatch_queue_t dataProcessingQueue;

+ (id) sharedInstance;
- (void)loadRSSFeedWithCallback:(void (^)(NSArray*))callback;

@end
