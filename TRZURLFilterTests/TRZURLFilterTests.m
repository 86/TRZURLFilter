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
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"filteringURLs.dat"];
    NSSet *set = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (set) {[NSKeyedArchiver archiveRootObject:nil toFile:filePath];}
    _urlFilter = [[TRZURLFilter alloc] init];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)test_addFilteringURLString_OK {
    [_urlFilter addFilteringURLString:@"http://addurl1.com/"];
    [_urlFilter addFilteringURLString:@"https://addurl1.com/"];
    [_urlFilter addFilteringURLString:@"https://addurl2.com/"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue([_urlFilter.filteringURLs containsObject:@"addurl1.com"]);
    XCTAssertTrue([_urlFilter.filteringURLs containsObject:@"addurl2.com"]);
    XCTAssertTrue(_urlFilter.filteringURLs.count == 2);
}

- (void)test_addFilteringURLString_NG {
    [_urlFilter addFilteringURLString:@"addurl3"];
    [_urlFilter addFilteringURLString:@"addurl3.com"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertFalse([_urlFilter.filteringURLs containsObject:@"addurl3"]);
    XCTAssertFalse([_urlFilter.filteringURLs containsObject:@"addurl3.com"]);
}


- (void)test_testFilterWithTargetURLString_OK {
    [_urlFilter addFilteringURLString:@"http://test.com/test/test"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue([_urlFilter testFilterWithTargetURLString:@"http://test.com/test/test"]);
    XCTAssertTrue([_urlFilter testFilterWithTargetURLString:@"http://test.com"]);

}

- (void)test_testFilterWithTargetURLString_NG {
    [_urlFilter addFilteringURLString:@"http://test2.test.com/"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertFalse([_urlFilter testFilterWithTargetURLString:@"http://test.com/"]);
    XCTAssertFalse([_urlFilter testFilterWithTargetURLString:@"http://test3.test.com/"]);
}

- (void)test_removeFilteringURLString_OK {
    [_urlFilter addFilteringURLString:@"http://removeurl.com"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    [_urlFilter removeFilteringURLString:@"http://removeurl.com"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertFalse ([_urlFilter testFilterWithTargetURLString:@"http://removeurl.com"]);
}

- (void)test_removeFilteringURLString_NG {
    [_urlFilter addFilteringURLString:@"http://removeurl2.com"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    [_urlFilter removeFilteringURLString:@"removeurl2.com"];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue ([_urlFilter testFilterWithTargetURLString:@"http://removeurl2.com"]);
}

- (void)test_removeAllFilteringURLs_OK {
    [_urlFilter addFilteringURLs:@[@"http://removeall1.com",@"http://removeall2.com",@"http://removeall3.com",]];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    [_urlFilter removeAllFilteringURLs];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue(_urlFilter.filteringURLs.count == 0);
}

- (void)test_save_OK {
    [_urlFilter removeAllFilteringURLs];
    [_urlFilter addFilteringURLs:@[@"http://saveurl1.com",@"http://saveurl2.com",@"http://saveurl3.com",]];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue([_urlFilter saveChanges]);
}

- (void)test_load_OK {
    [_urlFilter removeAllFilteringURLs];
    [_urlFilter addFilteringURLs:@[@"http://saveurl1.com",@"http://saveurl2.com",@"http://saveurl3.com",]];
    [_urlFilter saveChanges];
    _urlFilter = nil;
    _urlFilter = [[TRZURLFilter alloc] init];
    NSLog(@"filteringURLs:%@",_urlFilter.filteringURLs);
    XCTAssertTrue(_urlFilter.filteringURLs.count);
}


@end
