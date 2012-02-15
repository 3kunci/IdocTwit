//
//  TweetDetailViewController.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/15/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "TweetDetailViewController.h"

@interface TweetDetailViewController()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetLabel;

@end

@implementation TweetDetailViewController
@synthesize avatarView = _avatarView;
@synthesize fullnameLabel = _fullnameLabel;
@synthesize usernameLabel = _usernameLabel;
@synthesize dateLabel = _dateLabel;
@synthesize tweetLabel = _tweetLabel;

@synthesize tweet = _tweet;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.tweet) {
        self.avatarView.image = self.tweet.avatarImage;
        self.fullnameLabel.text = self.tweet.fullname;
        self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.username];
        self.tweetLabel.text = self.tweet.tweet;
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        self.dateLabel.text = [dateFormatter stringFromDate:self.tweet.date];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setAvatarView:nil];
    [self setFullnameLabel:nil];
    [self setUsernameLabel:nil];
    [self setDateLabel:nil];
    [self setTweetLabel:nil];
    [super viewDidUnload];
}
@end
