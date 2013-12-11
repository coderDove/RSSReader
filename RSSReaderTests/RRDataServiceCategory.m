//
//  RRDataServiceCategory.m
//  RSSReader
//
//  Created by Alexey on 22.10.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRDataServiceCategory.h"
#import "RRContstants.h"
#import "RRWebService.h"
#import "RRXMLDataParser.h"

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@implementation RRDataService (Test)

- (void)dataServiceTests_loadRSSFeedWithCallback:(void (^)(NSArray *))callback {
 
    dispatch_async(super.dataProcessingQueue, ^(){
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

- (NSArray*)mockResultArray {
    NSMutableArray *mockArray = mock([NSMutableArray class]);
    NSMutableDictionary *mockDictionary = mock([NSMutableDictionary class]);
    [mockDictionary setObject:@"object" forKey:@"key"];
    [mockArray addObject:mockDictionary];
    
    return mockArray;
}

@end

