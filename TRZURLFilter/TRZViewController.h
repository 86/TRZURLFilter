//
//  TRZViewController.h
//  TRZURLFilter
//
//  Created by yam on 2014/03/09.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRZViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *filterState;

- (IBAction)switchFilter:(id)sender;
- (IBAction)addFilteringURL:(id)sender;
- (IBAction)clearFilteringURLs:(id)sender;

@end
