//
//  TRZURLFilter.m
//  TRZURLFilter
//
//  Created by yam on 2014/03/05.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import "TRZURLFilter.h"

@interface TRZURLFilter ()

@property (nonatomic) NSMutableArray *filteringURLs;

@end

@implementation TRZURLFilter

- (void)commonInit {
    _filteringURLs = [[NSMutableArray alloc]init];
    NSString *path = @"filteringURLs";
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [string enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
        NSLog(@"%@", line);
        [_filteringURLs addObject:string];
    }];
}

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFilteringURLs:(NSArray *)urlArray {
    self = [super init];
    if (self) {
        [self commonInit];
        [self addFilteringURLs:urlArray];
    }
    return self;
}


- (void)addFilteringURLString:(NSString *)string {
    NSString *host = [[NSURL URLWithString:string] host];
    if (host) {
        [_filteringURLs addObject:host];
    } else {
        NSLog(@"addURL failed");
    }
}

- (void)addFilteringURLs:(NSArray *)urlArray {
    for (NSString *urlString in urlArray) {
        [_filteringURLs addObject:urlString];
    }
}

- (void)deleteFilteringURLString:(NSString *)string {
    
}

- (void)deleteAllFilteringURLs {
    
}

- (NSArray *)filteringURLs {
    NSArray *filteringURLs = [[NSArray alloc] initWithArray:_filteringURLs];
    return filteringURLs;
}

- (BOOL)testFilterWithTargetURLString:(NSString *)string {
    BOOL testResult = '\0';
    NSString *host = [[NSURL URLWithString:string] host];
    if (host) {
        testResult = [_filteringURLs containsObject:host];
    }
    return testResult;
}


@end