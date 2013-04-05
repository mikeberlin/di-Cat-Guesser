//
//  HighScoresViewController.m
//  CatGuesser
//
//  Created by Mike Berlin on 4/4/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import "HighScoresViewController.h"
#import "GuessingGame.h"

@interface HighScoresViewController ()

@property (nonatomic, strong) NSArray *scores;

@end

@implementation HighScoresViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"High Scores";
    self.scores = [[NSUserDefaults standardUserDefaults] arrayForKey:UD_HIGH_SCORES];

    [self.tvHighScores reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"HighScoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];

    id time = self.scores[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",time];

    return cell;
}

@end