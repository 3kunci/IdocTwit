//
//  TweetingViewController.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
- (IBAction)tweet:(id)sender;

@end
