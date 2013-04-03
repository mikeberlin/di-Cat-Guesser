//
//  Choice.h
//  CatGuesser
//
//  Created by Mike Berlin on 4/2/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Choice : NSObject

@property (nonatomic) NSInteger value;
@property (nonatomic) BOOL isEnabled;
@property (nonatomic) BOOL isAnswer;

@end