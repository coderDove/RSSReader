//
//  RSSReaderTests.m
//  RSSReaderTests
//
//  Created by Alexey on 16.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//
#import <objc/runtime.h>

#import "NewsListTests.h"
#import "RRNewsList.h"
#import "RRNewsList+RRNewsListCategory.h"
#import "RRNews.h"
#import "RRDataService+RRDataServiceCategory.h"
#import "RRNewsCell.h"


#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>


 @interface RRNewsList ()
 - (void)viewWillAppear:(BOOL)animated;
 - (IBAction)buttonRefreshClick:(id)sender;
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
 @end
 
 @implementation NewsListTests {
     RRNewsList *sut;
     RRDataService *dataService;
     UINavigationController *navController;
     NSIndexPath *firstCellIndexPath;
     RRNewsCell *firstCell;
     SEL realLoadDataSource, testLoadDataSource;
 }
 
 - (void)setUp {
     [super setUp];
     // Set-up code here.
     sut = [[RRNewsList alloc] init];
     [sut view];
     navController = [[UINavigationController alloc] initWithRootViewController: sut];
     [self mockDataSource];
     firstCellIndexPath = [NSIndexPath indexPathForRow: 0 inSection: 0];
     firstCell = [self loadFirstCell];
     realLoadDataSource = @selector(loadDataSource);
     testLoadDataSource = @selector(newsListTests_loadDataSource);
 
 }
 
 - (void)tearDown
 {
     // Tear-down code here.
     [sut release];
     [navController release];
     
     [super tearDown];
 }


- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find RRNewsList instance");
}
/*
- (void)testDataSourceExists {
    STAssertNotNil(sut.dataSource, @"Cannot find dataSource instance");
}

- (void)testTableViewExists {
    STAssertNotNil(sut.tableView, @"Cannot find tableView instance");
}
*/

#pragma mark -
#pragma mark Table View
- (void)testViewHasTableView {
    assertThat(sut.tableView, notNilValue());
}

- (void)testConformsToUITableViewDataSource {
    assertThat(sut, conformsTo(@protocol(UITableViewDataSource)));
}

- (void)testTableViewDataSourceIsConnected {
    assertThat(sut.tableView.dataSource, notNilValue());
}

- (void)testConformsToUITableViewDelegate {
    assertThat(sut, conformsTo(@protocol(UITableViewDelegate)));
}

- (void)testTableViewDelegateIsConnected {
    assertThat(sut.tableView.delegate, notNilValue());
}

- (void)testTableViewNumberOfRowsInSectionEqualsDataSourceCount {
    NSInteger expectedRowCount = sut.dataSource.count;
    NSInteger rowCount = [sut tableView:sut.tableView numberOfRowsInSection:0];
    XCTAssertTrue(rowCount == expectedRowCount, @"numberOfRowsInSection result should be equal to DataSource count.");
}

- (void)testRowDidSelectInvokesNewsVC {
    [self sutSelectRow];
    XCTAssertTrue([navController.topViewController isMemberOfClass:[RRNews class]], @"RRNews viewController was not shown");
}

- (void)sutSelectRow {
    [sut tableView:sut.tableView didSelectRowAtIndexPath:firstCellIndexPath];
}

#pragma mark -
#pragma mark Cell
- (RRNewsCell *)loadFirstCell {
    RRNewsCell *cell = (RRNewsCell*)[sut tableView: sut.tableView                                       cellForRowAtIndexPath: firstCellIndexPath];
    return cell;
}

- (void)testCellIsProperTypeCell {
    XCTAssertTrue([firstCell isMemberOfClass:[RRNewsCell class]], @"Cell has to be the RRNewsCell type");
}

- (void)testCellPropertiesHaveCorrectValues {
    XCTAssertTrue([firstCell.titleLabel.text isEqualToString:@"Title"], @"Cell title is wrong: %@", firstCell.titleLabel.text);
    XCTAssertTrue([firstCell.pubDateLabel.text isEqualToString:@"2013/01/01"], @"Cell pub date is wrong: %@", firstCell.pubDateLabel.text);
    XCTAssertTrue([[firstCell.icon.imageURL absoluteString] isEqualToString:@"http://google.com/image"], @"Cell icon URL is wrong: %@", [firstCell.icon.imageURL absoluteString]);
}

#pragma mark -
#pragma mark ViewController
- (void)testNewsVCGotCorrectURL {
    [self sutSelectRow];
    RRNews *mockNewsVC = (RRNews*)navController.topViewController;
    NSString *newsURLString = [[mockNewsVC valueForKey:@"currentURL"] absoluteString];
    XCTAssertTrue([newsURLString isEqualToString:@"http://google.com/title"], @"News URL is wrong: %@", newsURLString);
}

- (void)testViewWillAppearLoadsDataSource {
//    not good, but let it be as an example
    [self swizzleDataSourceMethods];
    [sut viewWillAppear:NO];
    [self checkLoadDataSourceMethod];
    [self swizzleDataSourceMethodsBack];
}

#pragma mark -
#pragma mark Actions
- (void)buttonRefreshClickLoadsData {
    [self swizzleDataSourceMethods];
    [sut buttonRefreshClick:self];
    [self checkLoadDataSourceMethod];
    [self swizzleDataSourceMethodsBack];
}

#pragma mark -
#pragma mark Internal
- (void)mockDataSource {
    NSMutableDictionary *mockDictionary =[NSMutableDictionary dictionaryWithDictionary:
                                          @{@"title": @"Title",
                                          @"link":@"http://google.com/title",
                                          @"pubDate":@"2013/01/01",
                                          @"image":@"http://google.com/image"}];
    NSMutableArray *mockArray = [NSMutableArray arrayWithObject:mockDictionary];
    
    sut.dataSource = mockArray;
}

- (void)checkLoadDataSourceMethod {
    XCTAssertNil(sut.dataSource, @"DataSource must be nil NOW!!!");
}
//one more test
- (void)testCheckLoadDataSourceMethod2 {
    [self swizzleMethodsForClass:[RRDataService class]
                        selector:@selector(loadRSSFeedWithCallback:)
                     andSelector:@selector(DataServiceTests_loadRSSFeedWithCallback:)];
    
    [self blockSnippet];
    
    [self swizzleMethodsForClass:[RRDataService class]
                        selector:@selector(DataServiceTests_loadRSSFeedWithCallback:)
                     andSelector:@selector(loadRSSFeedWithCallback:)];
}

//another one more test
- (void)testCheckLoadDataSourceMethod3 {
    Method origMethod = class_getInstanceMethod([RRDataService class], @selector(loadRSSFeedWithCallback:));
    IMP origMethodImp = class_getMethodImplementation([RRDataService class], @selector(loadRSSFeedWithCallback:));
    IMP overrideMethodImp = class_getMethodImplementation([RRDataService class], @selector(DataServiceTests_loadRSSFeedWithCallback:));
    
    class_replaceMethod([RRDataService class], @selector(loadRSSFeedWithCallback:), (IMP)overrideMethodImp, method_getTypeEncoding(origMethod));
    
    [self blockSnippet];
    
    class_replaceMethod([RRDataService class], @selector(loadRSSFeedWithCallback:), (IMP)origMethodImp, method_getTypeEncoding(origMethod));
}

- (void)blockSnippet {
    __block BOOL hasCalledBack = NO;
    [[RRDataService sharedInstance] loadRSSFeedWithCallback:^(NSArray *parsedDataArray){
        NSLog(@"Completion Block!");
        hasCalledBack = YES;
        XCTAssertTrue(parsedDataArray.count == 1, @"loadRSSFeedWithCallback method didn't return a proper NSArray object");
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:10];
    while (hasCalledBack == NO && [loopUntil timeIntervalSinceNow] > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:loopUntil];
    }
    
    if (!hasCalledBack){
        
        XCTFail(@"loadRSSFeedWithCallback did not finished after 10 sec working");
    }
}

- (void)swizzleDataSourceMethods {
    [self swizzleMethodsForClass:[RRNewsList class]
                        selector:realLoadDataSource
                     andSelector:testLoadDataSource];
}

- (void)swizzleDataSourceMethodsBack {
    [self swizzleMethodsForClass:[RRNewsList class]
                        selector:testLoadDataSource
                     andSelector:realLoadDataSource];
}
- (void)swizzleMethodsForClass:(Class)class selector:(SEL)sourceSelector andSelector:(SEL)destinationSelector {
    Method method1 = class_getInstanceMethod(class, sourceSelector);
    Method method2 = class_getInstanceMethod(class, destinationSelector);
    method_exchangeImplementations(method1, method2);
}


@end

