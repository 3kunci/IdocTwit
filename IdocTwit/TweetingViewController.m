//
//  TweetingViewController.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "TweetingViewController.h"
#import <Twitter/Twitter.h>
#import <QuartzCore/QuartzCore.h>

@implementation TweetingViewController
@synthesize tweetLabel, attachedImage;

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
        
        if (self.attachedImage) {
            [tweetComposerViewController addImage:self.attachedImage];
        }
        
        [self presentModalViewController:tweetComposerViewController animated:YES];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickImage"]) {
        ImagePickerViewController *imagePickerVC = (ImagePickerViewController *)segue.destinationViewController;
        imagePickerVC.delegate = self;
    }
}

- (void)dismissThisController:(UIViewController *)controller {
//    [self dismissModalViewControllerAnimated:YES];
    [self.view setHidden:NO];
    
    [UIView animateWithDuration:0.5 
                     animations:^{
                         [controller.view setAlpha:0.0];
                     } 
                     completion:^(BOOL finished) {
                         [controller willMoveToParentViewController:nil];
                         [controller removeFromParentViewController];
                         [controller.view removeFromSuperview];                         
                     }];
    
}

- (void)imagePickerController:(ImagePickerViewController *)controller didSelectImage:(UIImage *)image {
    [self dismissThisController:controller];
    
    self.attachedImage = image;
}

@end
