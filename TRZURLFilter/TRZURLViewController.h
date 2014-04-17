//
//  TRZURLViewController.h
//  TRZURLFilter
//
//  Created by yam on 2014/03/04.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRZURLViewController : UITableViewController

- (void)enableFilter;
- (void)disableFilter;
- (void)addFilteringURL;
- (void)removeAllURLs;

@property (nonatomic) BOOL filterState;

@end
