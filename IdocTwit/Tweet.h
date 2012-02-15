//
//  Tweet.h
//  IdocTwit
//
//  Created by Ikhsan Assaat on 2/14/12.
//  Copyright (c) 2012 3kunci. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *fullname;
@property (strong, nonatomic) UIImage *avatarImage;
@property (strong, nonatomic) NSString *tweet;
@property (strong, nonatomic) NSDate *date;

@end
