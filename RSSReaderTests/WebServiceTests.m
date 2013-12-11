//
//  WebServiceTests.m
//  RSSReader
//
//  Created by Alexey on 17.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "WebServiceTests.h"
#import "RRContstants.h"
#import "RRWebService.h"
#import "RRXMLDataParser.h"
#import "FakeURLResponse.h"

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@interface RRWebService ()
- (void)checkURLConnectionResponse:(NSURLResponse*)response;
- (void)checkURLConnectionError:(NSError*)error;
@end

@interface MockRRWebService : RRWebService
@end

@implementation MockRRWebService
- (NSData *)fetchDataWithURLString:(NSString *)url {
    NSError *error = nil;
    NSURLResponse* response = nil;
    
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    //prevent to start connection
    NSData* resultData = [xmlConstant dataUsingEncoding:NSUTF8StringEncoding];
    
    [self checkURLConnectionResponse:response];
    [self checkURLConnectionError:error];
    
    if (resultData.length == 0) {
        NSLog(@"!!! Nothing has been downloaded");
    }
    
    return resultData;
}

@end


@implementation WebServiceTests {
    MockRRWebService *sut;
    NSString *testURLString;
    FakeURLResponse* badResponse;
    FakeURLResponse* goodResponse;
    NSError *connectionError;
}

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    sut = [[MockRRWebService alloc] init];
    testURLString = [[NSString alloc] initWithString:@"http://google.com"];
    badResponse = [[FakeURLResponse alloc] initWithStatusCode:404];
    goodResponse = [[FakeURLResponse alloc] initWithStatusCode:200];
    connectionError = mock([NSError class]);
}

- (void)tearDown
{
    // Tear-down code here.
    [sut release];
    [testURLString release];
    [badResponse release];
    [goodResponse release];

    [super tearDown];
}

- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find RRWebService instance");
}

- (void)testUsesCorrectURL {
    [sut loadRSSFeedWithURLString:testURLString];
    NSString *sutURLString = [sut valueForKey:@"urlString"];
    XCTAssertTrue([testURLString isEqualToString:sutURLString], @"URL string values must to be the same");
}

- (void)testRequestIsNotNil {
    [sut loadRSSFeedWithURLString:testURLString];
    NSURLRequest *sutRequest = [sut valueForKey:@"request"];
    XCTAssertNotNil(sutRequest, @"URLRequest mustn't to be nil");
}

- (void)testBadRespondIsCaught {
    NSString *sutLogMessage = [self logMessageForURLConnectionResponse:(NSURLResponse*)badResponse];
    XCTAssertNotNil(sutLogMessage, @"Bad logMessage mustn't to be nil");
}

- (void)testGoodRespondIsNotCaught {
    NSString *sutLogMessage = [self logMessageForURLConnectionResponse:(NSURLResponse*)goodResponse];
    XCTAssertNil(sutLogMessage, @"Good logMessage must to be nil");
}
- (NSString *)logMessageForURLConnectionResponse:(NSURLResponse*)response {
    [sut checkURLConnectionResponse:response];
    NSString *sutLogMessage = [sut valueForKey:@"logMessage"];
    return sutLogMessage;
}

- (void)testConnectionErrorIsCaught {
    NSString *sutLogMessage = [self logMessageForURLConnectionError:connectionError];
    XCTAssertNotNil(sutLogMessage, @"Connection error logMessage mustn't to be nil");
}

- (void)testConnectionNonErrorIsNotCaught {
    NSString *sutLogMessage = [self logMessageForURLConnectionError:nil];
    XCTAssertNil(sutLogMessage, @"If success connection error logMessage must to be nil");
}
- (NSString *)logMessageForURLConnectionError:(NSError*)error {
    [sut checkURLConnectionError:error];
    NSString *sutLogMessage = [sut valueForKey:@"logMessage"];
    return sutLogMessage;
}


@end
