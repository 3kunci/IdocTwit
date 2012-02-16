//
//  ImagePickerViewController.m
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/16/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import "ImagePickerViewController.h"

@implementation ImagePickerViewController

@synthesize delegate;

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectImage:(UIButton *)button {
    UIImage *selectedImage = button.imageView.image;
    
    [self.delegate imagePickerController:self didSelectImage:selectedImage];
}

@end
