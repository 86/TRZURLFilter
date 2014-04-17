//
//  TRZURLViewController.m
//  TRZURLFilter
//
//  Created by yam on 2014/03/04.
//  Copyright (c) 2014年 yam. All rights reserved.
//

#import "TRZURLViewController.h"
#import "TRZURLFilter.h"

@interface TRZURLViewController ()


@property (nonatomic) NSMutableArray *contents;
@property (nonatomic) TRZURLFilter *urlFilter;


@end

@implementation TRZURLViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    NSLog(@"UVC:awakeFromNib");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"UVC:viewDidLoad");
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _contents = [NSMutableArray arrayWithArray:[self generateContents]];
    _urlFilter = [[TRZURLFilter alloc] init];
    _filterState = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _contents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString * urlString = [_contents objectAtIndex:indexPath.row];
    cell.textLabel.text = urlString;
    cell.textLabel.textColor  = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1.0f];
    
    // Perform Filter
    if (_filterState) {
        if([_urlFilter testFilterWithTargetURLString:urlString]) {
            NSLog(@"UVC:Filter ON");
            cell.textLabel.textColor  = [UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:1.0f];
        } else {
            NSLog(@"UVC:Filter OFF");
            cell.textLabel.textColor  = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:1.0f];
        }
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath");
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    NSLog(@"selectedRows:%@",[self.tableView indexPathsForSelectedRows]);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didDeselectRowAtIndexPath");
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    NSLog(@"selectedRows:%@",[self.tableView indexPathsForSelectedRows]);
}

#pragma mark - init contents

- (NSArray *)generateContents {
    NSArray *contents = @[@"http://sample1.com/",
                         @"http://sample1.com/sample/",
                         @"http://www.sample1.com/",
                         @"http://sample2.com/",
                         @"http://sample.sample2.com/",
                         @"http://sample3.com/",
                         ];
    return contents;
}

#pragma mark - URLFilter 

- (void)enableFilter {
    NSLog(@"UVC:enableFilter");
    _filterState = YES;
    [self.tableView reloadData];
    [self showMsg:@"Enabled filter"];
}

- (void)disableFilter {
    NSLog(@"UVC:disableFilter");
    _filterState = NO;
    [self.tableView reloadData];
}

- (void)addFilteringURL {
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    if (indexPaths.count > 1) {
        NSMutableArray *urlStrings = [[NSMutableArray alloc] init];
        for (NSIndexPath *indexPath in indexPaths) {
            [urlStrings addObject:[self.tableView cellForRowAtIndexPath:indexPath].textLabel.text];
            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
        [_urlFilter addFilteringURLs:urlStrings];
         NSLog(@"filter:%@",_urlFilter.filteringURLs);
        [self showMsg:@"Added the filtering URLs"];
    } else if (indexPaths.count == 1) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [_urlFilter addFilteringURLString:cell.textLabel.text];
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        NSLog(@"filter:%@",_urlFilter.filteringURLs);
        [self showMsg:@"Added the filtering URL"];
    }
    [self updateTableView];
}

- (void)removeAllURLs {
    if (_urlFilter.filteringURLs.count) {
        [_urlFilter removeAllFilteringURLs];
        NSLog(@"filter:%@",_urlFilter.filteringURLs);
        [self clearAllSelection];
        [self updateTableView];
        [self showMsg:@"Removed all filtering URLs"];
    }
}

- (void)updateTableView {
    if (_filterState) {
        [self.tableView reloadData];
    }
}

- (void)clearAllSelection {
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    if (indexPaths.count) {
        for (NSIndexPath *indexPath in indexPaths) {
            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
        }
    }
}

- (void)showMsg:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alertView show];
    double delayInSeconds = 0.7;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    });
}


@end
