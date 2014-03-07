//
//  TRZURLFilter.h
//  TRZURLFilter
//
//  Created by yam on 2014/03/05.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZURLFilter : NSObject

- (BOOL)testFilterWithTargetURLString:(NSString *)string;
- (void)addFilteringURLString:(NSString *)string;
- (void)addFilteringURLs:(NSArray *)urlArray;
- (void)deleteFilteringURLString:(NSString *)string;
- (void)deleteAllFilteringURLs;
- (NSArray *)filteringURLs;

@end