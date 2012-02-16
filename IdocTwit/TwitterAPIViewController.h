//
//  TwitterAPIViewController.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterAPIViewController;

@protocol TwitterAPIViewControllerDelegate <NSObject>

- (void)twitterAPIViewController:(TwitterAPIViewController *)controller 
                  didSelectTitle:(NSString *)title 
                         withURL:(NSURL *)url;

@end

@interface TwitterAPIViewController : UITableViewController

@property (nonatomic, assign) id <TwitterAPIViewControllerDelegate> delegate;
@property (nonatomic) NSUInteger selectedAPI;

@end
