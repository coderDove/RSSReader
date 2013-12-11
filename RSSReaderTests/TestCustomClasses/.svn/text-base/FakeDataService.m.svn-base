//
//  RRTestDataService.m
//  RSSReader
//
//  Created by Alexey on 20.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "FakeDataService.h"
#import "RRContstants.h"
#import "RRWebService.h"
#import "RRXMLDataParser.h"


#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@implementation FakeDataService
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
/*
- (void)loadRSSFeedWithCallback:(void (^)(NSArray *))callback {

    dispatch_async(_dataProcessingQueue, ^(){
        NSArray *parsedDataArray;
       
//        NSData *xmlData = nil;
        NSData *xmlData = [xmlConstant dataUsingEncoding:NSUTF8StringEncoding];
        RRWebService *webService = mock([RRWebService class]);
        [given([webService loadRSSFeed]) willReturn:xmlData];

//        parsedDataArray = [self mockResultArray];
//        RRXMLDataParser *xmlParser = mock([RRXMLDataParser class]);
//        [given([xmlParser parseXml:xmlData]) willReturn:parsedDataArray];
        
        if (xmlData.length > 0) {
            RRXMLDataParser *xmlParser = [[RRXMLDataParser alloc] init];
            parsedDataArray = [NSArray arrayWithArray:[xmlParser parseXml:xmlData]];
            [xmlParser release];
        }
        else {
            parsedDataArray = [self mockResultArray];
        }

        if(callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(parsedDataArray);
            });
        }
    });
}
*/

- (void)loadRSSFeedWithCallback:(void (^)(NSArray *))callback {
    
    dispatch_async(_dataProcessingQueue, ^(){
        NSArray *parsedDataArray = [self mockResultArray];

        if(callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(parsedDataArray);
            });
        }
    });
}

- (NSArray*)mockResultArray {
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    NSMutableDictionary *mockDictionary = mock([NSMutableDictionary class]);
    [mockDictionary setObject:@"object" forKey:@"key"];
    [mockArray addObject:mockDictionary];
    
    return mockArray;
}


@end
