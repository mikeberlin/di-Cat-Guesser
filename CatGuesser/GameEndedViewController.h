//
//  GameEndedViewController.h
//  CatGuesser
//
//  Created by Mike Berlin on 3/27/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface GameEndedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgGameOver;
@property (strong, nonatomic) MainViewController *parent;
@property BOOL wasDominated;

@end