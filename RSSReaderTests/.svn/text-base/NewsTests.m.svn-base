//
//  NewsTests.m
//  RSSReader
//
//  Created by Alexey on 23.09.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "NewsTests.h"
#import "RRNews.h"
#import "RRNewsList.h"

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>

@interface RRNews ()
- (void)viewDidLoad;
- (void)addActivityIndicatorView;
- (void)hideActivityIndicatorView;
- (void)logError:(NSError *)error;
@end


@interface MockRRNews : RRNews
@end

@implementation MockRRNews
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    request = [[NSURLRequest alloc]initWithURL:currentURL] ;
    //prevent to start connection
}

@end


@implementation NewsTests {
    MockRRNews *sut;
}


- (void)setUp
{
    [super setUp];
    // Set-up code here.
    sut = [[MockRRNews alloc] initWithURL:[NSURL URLWithString:@"http://www.bbc.co.uk/news/uk-24135219#sa-ns_mchannel=rss&amp;ns_source=PublicRSS20-sa"] nibName:@"RRNews" bundle:nil];
    [sut view];

}

- (void)tearDown
{
    // Tear-down code here.
    [sut release];
    
    [super tearDown];
}

- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find root RRNews instance");
}

- (void)testDataSourceExists {
    XCTAssertNotNil(sut.webView, @"Cannot find WebView instance");
}

- (void)testConformsToUITableViewDataSource {
    assertThat(sut, conformsTo(@protocol(UIWebViewDelegate)));
}

- (void)testTableViewDelegateIsConnected {
    assertThat(sut.webView.delegate, notNilValue());
}

#pragma mark UIWebView
- (void)testViewDidLoadCreatesRequest {
    [sut viewDidLoad];
    NSURLRequest *request = [sut valueForKey:@"request"];
    XCTAssertNotNil(request, @"URLRequest must be not nil");
}

- (void)testLogError {
    [self imitateError];
    NSString *sutLogMessage = [sut valueForKey:@"logMessage"];
    XCTAssertNotNil(sutLogMessage, @"WebView error logMessage mustn't to be nil");
}

- (void)imitateError {
    NSError *error = mock([NSError class]);
    [sut logError:error];
}

- (void)testLogErrorHidesIndicatorView {
    [self imitateError];
    XCTAssertFalse([sut.view.subviews containsObject:[sut valueForKey:@"activityView"]], @"Activity indicator must be hidden");
}

- (void)testActivityIndicatorViewAdding {
    [sut addActivityIndicatorView];
//    STAssertTrue([sut.view.subviews.lastObject isMemberOfClass:[UIActivityIndicatorView class]], @"Activity indicator was not shown");
    XCTAssertTrue([sut.view.subviews containsObject:[sut valueForKey:@"activityView"]], @"Activity indicator was not shown");
}

- (void)testActivityIndicatorViewIsHidden {
    [sut addActivityIndicatorView];
    [sut hideActivityIndicatorView];
    XCTAssertTrue([[sut valueForKey:@"activityView"] isHidden], @"Activity indicator must be hidden");
}


#pragma mark Button Done
- (void)testButtonDoneReturnsBack {
    RRNewsList *mockNewsListVC = [[RRNewsList alloc]init];
    UINavigationController *mockNavController = [[UINavigationController alloc] init];
    [mockNavController setViewControllers:[NSArray arrayWithObjects:mockNewsListVC, sut, nil]];

    [sut buttonDoneClick:sut];

    XCTAssertFalse([mockNavController.viewControllers containsObject:sut], @"RRNewsList must be shown");
    [mockNewsListVC release];
    [mockNavController release];
}


@end
