//
//  RRDataService+RRDataServiceCategory.m
//  RSSReader
//
//  Created by Alexey on 25.10.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "RRDataService+RRDataServiceCategory.h"

@implementation RRDataService (RRDataServiceCategory)

- (void)DataServiceTests_loadRSSFeedWithCallback:(void (^)(NSArray *))callback {
    
    dispatch_async(self.dataProcessingQueue, ^(){
        NSArray *parsedDataArray = [self mockResultArray];
        
        if(callback) {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(parsedDataArray);
            });
        }
    });
}

- (NSArray*)mockResultArray {
    
    NSMutableDictionary *mockDictionary =[NSMutableDictionary  dictionaryWithObject:@"object" forKey:@"key"];
    NSMutableArray *mockArray = [NSMutableArray arrayWithObject:mockDictionary];
    
    return mockArray;

}

@end
