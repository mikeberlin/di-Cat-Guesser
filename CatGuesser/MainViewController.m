//
//  MainViewController.m
//  CatGuesser
//
//  Created by Mike Berlin on 3/27/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import "MainViewController.h"
#import "GameEndedViewController.h"
#import "GuessingGame.h"
#import "HighScoresViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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
}

- (void)viewDidAppear:(BOOL)animated
{
    //self.game = [[GuessingGame alloc] initGameWithMaxChoices:[self.catButtonCollection count]];

    self.game = [[GuessingGame alloc] init];
    self.game.maxChoices = [self.catButtonCollection count];
    [self.game startGame];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] init];
    barButton.title = @"Back";

    self.navigationItem.backBarButtonItem = barButton;
    self.title = @"Cat Guessing Game";
    
    [self syncUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)catSelected:(UIButton *)sender
{
    Choice *selectedAnswer = [self.game choiceAtIndex:[sender.titleLabel.text intValue] - 1];
    selectedAnswer.isEnabled = NO;
    [self.game choiceMade:selectedAnswer];

    if ([self.game isGameLost])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You lose"
                                                        message:@"Better luck next time. Keep trying, you'll get it!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Try again..."
                                              otherButtonTitles:nil, nil];

        [alert show];
        [self.game restartGame];
    }

    [self syncUI];
}

- (IBAction)btnRestart:(UIButton *)sender
{
    [self.game restartGame];
    [self syncUI];
}

- (IBAction)btnShowScores:(UIButton *)sender
{
    HighScoresViewController *vcHighScores = [[HighScoresViewController alloc] init];
    [self.navigationController pushViewController:vcHighScores animated:YES];
}

- (void)syncUI
{
    for (UIButton *btnCat in self.catButtonCollection) {
        Choice *choice = [self.game choiceAtIndex:[btnCat.titleLabel.text intValue] - 1];
        btnCat.hidden = !choice.isEnabled;
    }

    for (int i=0; i < [self.winningCatsCollection count]; i++) {
        UIImageView *imgCat = (UIImageView *)[self.winningCatsCollection objectAtIndex:i];
        imgCat.hidden = ((i + 1) > self.game.numWins);
    }

    if (self.game.isDominated) [self showEndGameScreen:YES];
    if (self.game.wasDominated) [self showEndGameScreen:NO];
}

- (void)showEndGameScreen:(BOOL)wasDominated
{
    GameEndedViewController *vcEndGame = [[GameEndedViewController alloc] init];
    vcEndGame.WasDominated = wasDominated;
    vcEndGame.Parent = self;
    
    [self presentViewController:vcEndGame animated:YES completion:nil];
}

@end