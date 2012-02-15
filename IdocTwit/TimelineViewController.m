//
//  TimelineViewController.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/15/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "TimelineViewController.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import "Tweet.h"
#import "TweetCell.h"
#import "TweetDetailViewController.h"

@interface TimelineViewController()

@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) NSURL *url;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (strong, nonatomic) NSMutableDictionary *imageCache;


- (NSMutableArray *)processingTweetsResponses:(NSData *)responseData;
- (void)refreshTweets;
- (IBAction)refresh:(id)sender;

@end

@implementation TimelineViewController

@synthesize tweets = _tweets;
@synthesize dateFormatter = _dateFormatter;
@synthesize accountStore = _accountStore;
@synthesize url = _url;
@synthesize refreshButton = _refreshButton;
@synthesize imageCache = _imageCache;

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    }
    
    return _dateFormatter;
}

- (ACAccountStore *)accountStore {
    if (!_accountStore) {
        _accountStore = [[ACAccountStore alloc] init];
    }
    
    return _accountStore;
}

- (NSURL *)url {
    if (!_url) {
        _url = [[NSURL alloc] initWithString:@"https://api.twitter.com/1/statuses/home_timeline.json"];
    }
    
    return _url;
}

- (NSMutableDictionary *)imageCache {
    if (!_imageCache) {
        _imageCache = [[NSMutableDictionary alloc] init];
    }
    
    return _imageCache;
}

#pragma mark - Fetching Tweets Methods

- (IBAction)refresh:(id)sender {
    [self refreshTweets];
}

- (NSMutableArray *)processingTweetsResponses:(NSData *)responseData {
    NSError *error = nil;
    NSDictionary *responseDictionary = (NSDictionary *) [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    NSMutableArray *tweetsArray = [NSMutableArray arrayWithCapacity:responseDictionary.count];
    
    for (id tweetDictionary in responseDictionary) {
        // allocating a tweet
        Tweet *aTweet = [[Tweet alloc] init];
        
        // fetch the username
        aTweet.username = [[tweetDictionary objectForKey:@"user"] objectForKey:@"screen_name"];
        
        // fetch the full name
        aTweet.fullname = [[tweetDictionary objectForKey:@"user"] objectForKey:@"name"];
        
        // get the image from the url
//        NSString *imageUrl = [[tweetDictionary objectForKey:@"user"] objectForKey:@"profile_image_url"];
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
//        aTweet.avatarImage = [UIImage imageWithData:imageData];
        aTweet.avatarLink = [[tweetDictionary objectForKey:@"user"] objectForKey:@"profile_image_url"];
        
        // get the date
        NSString *dateString = [tweetDictionary objectForKey:@"created_at"];
        aTweet.date = [self.dateFormatter dateFromString:dateString];
        
        // get the actual tweet
        aTweet.tweet = [tweetDictionary objectForKey:@"text"];
        
        [tweetsArray addObject:aTweet];
    }
    
    return tweetsArray;
}

- (void)refreshTweets {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.refreshButton setEnabled:NO];
    
    ACAccountType *accountType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [self.accountStore requestAccessToAccountsWithType:accountType 
                                 withCompletionHandler:^(BOOL granted, NSError *error) {
                                     if (granted) {
                                         NSArray *accounts = [self.accountStore accountsWithAccountType:accountType];
                                         ACAccount *firstAccount = [accounts objectAtIndex:0];
                                         
                                         TWRequest *request = [[TWRequest alloc] initWithURL:self.url parameters:nil requestMethod:TWRequestMethodGET];
                                         [request setAccount:firstAccount];
                                         
                                         [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                             if ([urlResponse statusCode] == 200) {
                                                 self.tweets = [self processingTweetsResponses:responseData];
                                                 
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     [self.tableView reloadData];
                                                     
                                                     [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                                                     [self.refreshButton setEnabled:YES];
                                                 });
                                             }
                                         }];
                                     }
                                 }];
}

- (UIImage *)fetchAvatarImageFromUrl:(NSString *)imageURL {
    return nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshTweets];
}

- (void)viewDidUnload {
    [self setRefreshButton:nil];
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source & delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = (TweetCell *)[tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    Tweet *aTweet = [self.tweets objectAtIndex:indexPath.row];
    cell.usernameLabel.text = [NSString stringWithFormat:@"@%@", aTweet.username];
    cell.tweetLabel.text = aTweet.tweet;
    
    cell.avatarView.image = nil;
    dispatch_queue_t fetchImageQueue = dispatch_queue_create("Avatar Fetch", NULL);
    dispatch_async(fetchImageQueue, ^{
        UIImage *fetchedImage = [self.imageCache objectForKey:aTweet.avatarLink];
        if (!fetchedImage) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:aTweet.avatarLink]];
            fetchedImage = [UIImage imageWithData:imageData];
            [self.imageCache setObject:fetchedImage forKey:aTweet.avatarLink];
        }
        
        aTweet.avatarImage = fetchedImage;

        dispatch_async(dispatch_get_main_queue(), ^{
            cell.avatarView.image = fetchedImage;
        });
    });
    dispatch_release(fetchImageQueue);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    Tweet *selectedTweet = [self.tweets objectAtIndex:selectedIndexPath.row];
    
    TweetDetailViewController *tweetDetailVC = (TweetDetailViewController *)segue.destinationViewController;
    tweetDetailVC.tweet = selectedTweet;
}


@end
