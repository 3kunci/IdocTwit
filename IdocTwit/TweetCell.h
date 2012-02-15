//
//  TweetCell.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/14/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetLabel;

@end
