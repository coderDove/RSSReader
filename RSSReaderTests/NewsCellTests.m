//
//  NewsCellTests.m
//  RSSReader
//
//  Created by Alexey on 20.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "NewsCellTests.h"
#import "RRNewsCell.h"


@implementation NewsCellTests {
    RRNewsCell *sut;
}


- (void)setUp
{
    [super setUp];
    // Set-up code here.
    sut = [[RRNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RRNewsCell"];
}

- (void)tearDown
{
    // Tear-down code here.
    [sut release];
    
    [super tearDown];
}


- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find root RRNewsCell instance");
}
/*
- (void)testTitleLabelExists {
    STAssertEquals(sut.titleLabel.text, @"Label", @"Cannot find titleLabel instance");
}

- (void)testPubDateLabelExists {
    STAssertNotNil(sut.pubDateLabel, @"Cannot find pubDateLabel instance");
}

- (void)testIconExists {
    STAssertNotNil(sut.icon, @"Cannot find icon instance");
}
*/
@end
