//
//  MainViewController.h
//  CatGuesser
//
//  Created by Mike Berlin on 3/27/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *winningCatsCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *catButtonCollection;
@property BOOL ResetGame;

- (IBAction)catSelected:(id)sender;
- (IBAction)btnRestart:(id)sender;

@end