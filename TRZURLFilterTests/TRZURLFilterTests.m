//
//  TRZURLFilterTests.m
//  TRZURLFilterTests
//
//  Created by yam on 2014/03/04.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRZURLFilter.h"

@interface TRZURLFilterTests : XCTestCase

@property (nonatomic) TRZURLFilter *urlFilter;

@end

@implementation TRZURLFilterTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _urlFilter = [[TRZURLFilter alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test_addFilteringURLString_OK {
    [_urlFilter addFilteringURLString:@"http://address1.com/"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue([_urlFilter.filteringURLs containsObject:@"address1.com"]);
}

- (void)test_addFilteringURLString_NG {
    [_urlFilter addFilteringURLString:@"test"];
    [_urlFilter addFilteringURLString:@"address2.com"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertFalse([_urlFilter.filteringURLs containsObject:@"test"]);
    XCTAssertFalse([_urlFilter.filteringURLs containsObject:@"address2.com"]);
}

- (void)test_testFilterWithTargetURLString_OK {
    [_urlFilter addFilteringURLString:@"http://www.triaedz.com/products/Hotrnetry/"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue([_urlFilter testFilterWithTargetURLString:@"http://www.triaedz.com/products/Cycle"]);
    XCTAssertTrue([_urlFilter testFilterWithTargetURLString:@"https://www.triaedz.com"]);

}

- (void)test_testFilterWithTargetURLString_NG {
    [_urlFilter addFilteringURLString:@"http://86.tumblr.com/"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertFalse([_urlFilter testFilterWithTargetURLString:@"http://tumblr.com/"]);
    XCTAssertFalse([_urlFilter testFilterWithTargetURLString:@"http://78.tumblr.com/"]);
    XCTAssertFalse([_urlFilter testFilterWithTargetURLString:@"test"]);
}


@end
