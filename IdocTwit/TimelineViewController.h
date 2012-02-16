//
//  TimelineViewController.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/15/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterAPIViewController.h"

@interface TimelineViewController : UITableViewController <TwitterAPIViewControllerDelegate>

@property (strong, nonatomic) NSURL *url;
@property (nonatomic) NSUInteger selectedAPI;

@end
