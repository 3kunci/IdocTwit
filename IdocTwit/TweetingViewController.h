//
//  TweetingViewController.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePickerViewController.h"

@interface TweetingViewController : UIViewController <ImagePickerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (strong, nonatomic) UIImage *attachedImage;

- (IBAction)tweet:(id)sender;

@end
