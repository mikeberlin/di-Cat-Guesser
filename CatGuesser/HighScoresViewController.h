//
//  HighScoresViewController.h
//  CatGuesser
//
//  Created by Mike Berlin on 4/4/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoresViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvHighScores;

@end