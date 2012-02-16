//
//  ImagePickerViewController.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImagePickerViewController;

@protocol ImagePickerDelegate <NSObject>

- (void)imagePickerController:(ImagePickerViewController *)controller didSelectImage:(UIImage *)image;

@end

@interface ImagePickerViewController : UIViewController

@property (assign, nonatomic) id <ImagePickerDelegate> delegate;

@end
