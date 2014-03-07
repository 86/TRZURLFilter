//
//  TRZURLFilter.m
//  TRZURLFilter
//
//  Created by yam on 2014/03/05.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import "TRZURLFilter.h"

@interface TRZURLFilter ()

@property (nonatomic) NSMutableSet *filteringURLs;

@end

@implementation TRZURLFilter

- (void)commonInit {
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"filteringURLs.dat"];
    NSSet *set = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (set) {
        _filteringURLs = [[NSMutableSet alloc] initWithSet:set];
        for (NSString *str in _filteringURLs) {
            NSLog(@"data loaded:%@", str);
        }
    } else {
        _filteringURLs = [[NSMutableSet alloc] init];
        NSLog(@"%@", @"no data");
    }
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
        [self addFilteringURLString:urlString];
    }
}

- (void)removeFilteringURLString:(NSString *)string {
    NSString *host = [[NSURL URLWithString:string] host];
    if (host) {
        [_filteringURLs removeObject:host];
    }
}

- (void)removeAllFilteringURLs {
    [_filteringURLs removeAllObjects];
}

- (NSSet *)filteringURLs {
    NSSet *filteringURLs = [[NSSet alloc] initWithSet:_filteringURLs];
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

- (BOOL)saveChanges {
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [directory stringByAppendingPathComponent:@"filteringURLs.dat"];
    BOOL successful = [NSKeyedArchiver archiveRootObject:_filteringURLs toFile:filePath];
    if (successful) {
        NSLog(@"%@", @"save complete");
    } else {
        NSLog(@"%@", @"save failed");
    }
    return successful;
}

@end