//
//  DataServiceTests.m
//  RSSReader
//
//  Created by Alexey on 17.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//
#import <objc/runtime.h>

#import "DataServiceTests.h"
//#import "RRDataService.h"
#import "RRDataService+RRDataServiceCategory.h"
#import "RRContstants.h"

#import "RRXMLDataParser.h"

//#import "FakeDataService.h"


#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>


@implementation DataServiceTests {
    RRDataService *sut;
    SEL realMethod, testMethod;
}

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    sut = [[RRDataService alloc] init];
    realMethod = @selector(loadRSSFeedWithCallback:);
    testMethod = @selector(DataServiceTests_loadRSSFeedWithCallback:);
   
}

- (void)tearDown
{
    [sut release];
    [super tearDown];
}

- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find RRTestDataService instance");
}

- (void)testSharedInstanceNotNil {
    RRDataService *dataService = [RRDataService sharedInstance];
    XCTAssertNotNil(dataService, @"sharedInstance is nil");
}

- (void)testSharedInstanceReturnsSameSingletonObject {
    RRDataService *dataService1 = [RRDataService sharedInstance];
    RRDataService *dataService2 = [RRDataService sharedInstance];
    XCTAssertEqual(dataService1, dataService2, @"sharedInstance didn't return same object twice");
}

- (void)testDataProcessingQueueExists {
    XCTAssertNotNil(sut.dataProcessingQueue, @"Cannot find dataProcessingQueue instance");
}
//useless
/*
- (void)testLoadDataSourceMethodReturnsArray {
    [self swizzleDataServiceMethods];

    __block BOOL hasCalledBack = NO;

    [sut loadRSSFeedWithCallback:^(NSArray* parsedTextArray){
        NSLog(@"Completion Block!");
        hasCalledBack = YES;
        STAssertTrue([parsedTextArray isKindOfClass:[NSArray class]], @"loadRSSFeedWithCallback method didn't return a NSArray object");
    }];

    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack){

        STFail(@"loadRSSFeedWithCallback did not finished after 10 sec working");
    }
    [self swizzleDataServiceMethodsBack];
}
*/
#pragma mark -
#pragma mark Internal
- (void)swizzleDataServiceMethods {
    [self swizzleMethodsForClass:[RRDataService class]
                        selector:realMethod
                     andSelector:testMethod];
}

- (void)swizzleDataServiceMethodsBack {
    [self swizzleMethodsForClass:[RRDataService class]
                        selector:testMethod
                     andSelector:realMethod];
}

- (void)swizzleMethodsForClass:(Class)class selector:(SEL)sourceSelector andSelector:(SEL)destinationSelector {
    
    Method method1 = class_getInstanceMethod(class, sourceSelector);
    Method method2 = class_getInstanceMethod(class, destinationSelector);
    
    method_exchangeImplementations(method1, method2);
}

@end




