//
//  NewspaperSegue.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "NewspaperSegue.h"

@implementation NewspaperSegue

- (void)perform {
    UIViewController *sourceVC = (UIViewController *)self.sourceViewController;
    UIViewController *destinationVC = (UIViewController *)self.destinationViewController;
    
    [UIView transitionFromView:sourceVC.view 
                        toView:destinationVC.view 
                      duration:1.0 
                       options:UIViewAnimationOptionTransitionCurlUp 
                    completion:^(BOOL finished) {
                        [sourceVC presentModalViewController:destinationVC animated:NO];
                    }];
}

@end
