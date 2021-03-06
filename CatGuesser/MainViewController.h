//
//  MainViewController.h
//  CatGuesser
//
//  Created by Mike Berlin on 3/27/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessingGame.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *catButtonCollection;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *winningCatsCollection;

@property (nonatomic) GuessingGame *game;

- (IBAction)catSelected:(id)sender;
- (IBAction)btnRestart:(UIButton *)sender;
- (IBAction)btnShowScores:(UIButton *)sender;
- (void)syncUI;

@end