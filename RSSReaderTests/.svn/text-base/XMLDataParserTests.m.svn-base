//
//  XMLDataParserTests.m
//  RSSReader
//
//  Created by Alexey on 18.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "XMLDataParserTests.h"
#import "RRContstants.h"
#import "RRXMLDataParser.h"

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@implementation XMLDataParserTests {
    RRXMLDataParser *sut;
}

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    sut = [[RRXMLDataParser alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    [sut release];
    
    [super tearDown];
}

- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find RRXMLDataParser instance");
}

- (NSArray *)xmlMethodInvoke {
    NSData *xmlData = [xmlConstant dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* parsedTextArray = [sut parseXml:xmlData];
    return parsedTextArray;
}

- (void)testXMLDataParserReturnsArray {
    NSArray *parsedTextArray = [self xmlMethodInvoke];
    XCTAssertTrue([parsedTextArray isKindOfClass:[NSArray class]], @"parseXml method didn't return a NSArray object");
}

- (void)testXMLDataParserReturnsArrayWithDictionaries {
    NSArray *parsedTextArray = [self xmlMethodInvoke];
    if (parsedTextArray.count > 0) {
        XCTAssertTrue([[parsedTextArray objectAtIndex:0] isKindOfClass:[NSDictionary class]], @"parseXml method result array doesn't contain a NSDictionary object");
    } else {
        XCTFail(@"parseXml method result array doesn't contain any object");
    }
}

- (void)testXMLDataParserReturnsArrayWithDictionariesWithTitleKey {
    [self assertParsedXMLDictionaryForKey:@"title"];
}

- (void)testXMLDataParserReturnsArrayWithDictionariesWithLinkKey {
    [self assertParsedXMLDictionaryForKey:@"link"];
}

- (void)testXMLDataParserReturnsArrayWithDictionariesWithPubDateKey {
    [self assertParsedXMLDictionaryForKey:@"pubDate"];
}

- (void)testXMLDataParserReturnsArrayWithDictionariesWithImageKey {
    [self assertParsedXMLDictionaryForKey:@"image"];
}

- (void)assertParsedXMLDictionaryForKey:(NSString*)key {
    NSArray *parsedTextArray = [self xmlMethodInvoke];
    if (parsedTextArray.count > 0) {
        NSDictionary *testDictionary = [parsedTextArray objectAtIndex:0];
        XCTAssertNotNil([testDictionary objectForKey:key], @"a NSDictionary object doesn't contain the '%@' key", key);
    }
}
@end
