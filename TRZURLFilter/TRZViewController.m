//
//  TRZViewController.m
//  TRZURLFilter
//
//  Created by yam on 2014/03/09.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import "TRZViewController.h"
#import "TRZURLViewController.h"

@interface TRZViewController ()

@property (nonatomic, weak) TRZURLViewController* urlViewController;

@end

@implementation TRZViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)awakeFromNib {
   NSLog(@"MVC:awakeFromNib");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"MVC:viewDidLoad");
    if(_urlViewController.filterState) {
        _filterState.on = YES;
    } else { _filterState.on = NO;}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"loadContainer"]) {
        NSLog(@"VC:prepareForSegue");
        TRZURLViewController *urlController = segue.destinationViewController;
        _urlViewController = urlController;
    }
}

- (IBAction)switchFilter:(id)sender {
    NSLog(@"VC:switchFilter");
    if (_filterState.on) {
        [_urlViewController enableFilter];
    } else {
        [_urlViewController disableFilter];
    }
}

- (IBAction)addFilteringURL:(id)sender {
    [_urlViewController addFilteringURL];
}

- (IBAction)clearFilteringURLs:(id)sender {
    [_urlViewController removeAllURLs];
}

@end
