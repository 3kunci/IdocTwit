//
//  TweetingViewController.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "TweetingViewController.h"
#import <Twitter/Twitter.h>

@implementation TweetingViewController
@synthesize tweetLabel;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setTweetLabel:nil];
    [super viewDidUnload];
}

- (IBAction)tweet:(id)sender {
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetComposerViewController = [[TWTweetComposeViewController alloc] init];
        [tweetComposerViewController setInitialText:self.tweetLabel.text];
        
        [self presentModalViewController:tweetComposerViewController animated:YES];
    }
}

@end
