//
//  AppDelegateTests.m
//  RSSReader
//
//  Created by Alexey on 24.10.13.
//  Copyright (c) 2013 Alexey. All rights reserved.
//

#import "AppDelegateTests.h"
#import "RRAppDelegate.h"

@implementation AppDelegateTests{
    RRAppDelegate *sut;
    UIWindow *window;
    UINavigationController *navigationController;
    BOOL didFinishLaunchingWithOptionsReturn;
}


- (void)setUp
{
    [super setUp];
    // Set-up code here.
    sut = [[RRAppDelegate alloc] init];

    didFinishLaunchingWithOptionsReturn = [sut application: nil didFinishLaunchingWithOptions: nil];
}

- (void)tearDown
{
    // Tear-down code here.
    [sut release];
    
    [super tearDown];
}


- (void)testSUTExists {
    XCTAssertNotNil(sut, @"Cannot find root RRAppDelegate instance");
}

- (void)testWindowIsKeyAfterApplicationLaunch {
    XCTAssertTrue(sut.window.keyWindow, @"App delegate's window should be key");
}


- (void)testAppDidFinishLaunchingReturnsYES {
    XCTAssertTrue(didFinishLaunchingWithOptionsReturn, @"Method should return YES");
}


- (void)testRootViewControllerContainsNavigationController {

    XCTAssertTrue([sut.window.rootViewController isMemberOfClass:[UINavigationController class]], @"RootViewController must be UINavigationController class");
    
}

@end
