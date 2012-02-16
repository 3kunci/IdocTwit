//
//  TwitterAPIViewController.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "TwitterAPIViewController.h"


@implementation TwitterAPIViewController

@synthesize selectedAPI;
@synthesize delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedAPI inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *oldCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedAPI inSection:0]];
    oldCell.accessoryType = UITableViewCellAccessoryNone;
    
    UITableViewCell *newCell = [self.tableView cellForRowAtIndexPath:indexPath];
    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.selectedAPI = indexPath.row;
    
    [self.delegate twitterAPIViewController:self 
                             didSelectTitle:newCell.textLabel.text 
                                    withURL:[NSURL URLWithString:newCell.detailTextLabel.text]];
}


@end
