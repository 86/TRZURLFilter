//
//  TRZURLFilter.h
//  TRZURLFilter
//
//  Created by yam on 2014/03/05.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZURLFilter : NSObject

- (void)addFilteringURLString:(NSString *)string;
- (void)addFilteringURLs:(NSArray *)urlArray;
- (void)removeFilteringURLString:(NSString *)string;
- (void)removeAllFilteringURLs;
- (BOOL)testFilterWithTargetURLString:(NSString *)string;
- (BOOL)saveChanges;
- (NSSet *)filteringURLs;

@end