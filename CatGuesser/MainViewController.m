//
//  MainViewController.m
//  CatGuesser
//
//  Created by Mike Berlin on 3/27/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import "MainViewController.h"
#import "GameEndedViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

#define MAX_GUESSES 4
#define MAX_LOSSES 4
#define MAX_WINS 3

static NSString *udNumWins = @"NumWins";
static NSString *udNumLosses = @"NumLosses";
NSArray *possibleCorrectAnswers;

int numGuesses;
int winningNumber;
int numWins;
int numLosses;

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
    if (self.ResetGame)
    {
        [self resetGame];
        self.ResetGame = NO;
    }

    [self initGame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)catSelected:(UIButton *)sender
{
    numGuesses++;

    UIButton *btnSender = [self.catButtonCollection objectAtIndex:[self.catButtonCollection indexOfObject:sender]];
    btnSender.hidden = YES;
    int numberGuessed = [btnSender.titleLabel.text intValue];

    if (numberGuessed == winningNumber)
    {
        numWins++;
        [self setUserDefaultNumWins];
        [self initGame];
    }
    else if (numGuesses >= MAX_GUESSES)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You lose"
                                                        message:@"Better luck next time. Keep trying, you'll get it!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Try again..."
                                              otherButtonTitles:nil, nil];

        numLosses++;
        [self setUserDefaultNumLosses];
        [alert show];
        [self initGame];
    }
}

- (IBAction)btnRestart:(id)sender
{
    [self initGame];
}

- (void)initGame
{
    numGuesses = 0;
    numWins = [[NSUserDefaults standardUserDefaults] integerForKey:udNumWins];
    numLosses = [[NSUserDefaults standardUserDefaults] integerForKey:udNumLosses];

    possibleCorrectAnswers = @[@1, @2, @3, @4, @6, @7, @8, @9];
    winningNumber = [[possibleCorrectAnswers objectAtIndex:arc4random_uniform([possibleCorrectAnswers count])] intValue];

    for (UIButton *btnCat in self.catButtonCollection) {
        btnCat.hidden = NO;
    }

    for (int i=0; i < [self.winningCatsCollection count]; i++) {
        UIImageView *imgCat = (UIImageView *)[self.winningCatsCollection objectAtIndex:i];
        imgCat.hidden = ((i + 1) > numWins);
    }

    if (numWins >= MAX_WINS) [self showEndGameScreen:YES];
    if (numLosses >= MAX_LOSSES) [self showEndGameScreen:NO];

    NSLog(@"Winning Number: %d", winningNumber);
}

- (void)resetGame
{
    numWins = 0;
    numLosses = 0;

    [self setUserDefaultNumWins];
    [self setUserDefaultNumLosses];
    [self initGame];
}

- (void)showEndGameScreen:(BOOL)wasDominated
{
    GameEndedViewController *vcEndGame = [[GameEndedViewController alloc] init];
    vcEndGame.WasDominated = wasDominated;
    vcEndGame.Parent = self;

    [self presentViewController:vcEndGame animated:YES completion:nil];
}

- (void)setUserDefaultNumWins
{
    [[NSUserDefaults standardUserDefaults] setInteger:numWins forKey:udNumWins];
}

- (void)setUserDefaultNumLosses
{
    [[NSUserDefaults standardUserDefaults] setInteger:numLosses forKey:udNumLosses];
}

@end