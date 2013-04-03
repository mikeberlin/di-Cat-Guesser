//
//  GuessingGame.m
//  CatGuesser
//
//  Created by Mike Berlin on 4/2/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import "GuessingGame.h"

@implementation GuessingGame

@synthesize numWins;
@synthesize numLosses;

#pragma Properties
- (void)setNumWins:(NSInteger)wins
{
    numWins = wins;
    [[NSUserDefaults standardUserDefaults] setInteger:wins forKey:UD_NUM_WINS_KEY];
}

- (NSInteger)numWins
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:UD_NUM_WINS_KEY];
}

- (void)setNumLosses:(NSInteger)losses
{
    numLosses = losses;
    [[NSUserDefaults standardUserDefaults] setInteger:losses forKey:UD_NUM_LOSSES_KEY];
}

- (NSInteger)numLosses
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:UD_NUM_LOSSES_KEY];
}

#pragma Constructors
- (id)initGameWithMaxChoices:(NSInteger)maxChoices
{
    self = [super init];

    if (self) {
        self.maxChoices = maxChoices;
        [self restartGame];
    }

    return self;
}

- (void)initChoicesWithAnswer:(NSInteger)answer
{
    [self.choices removeAllObjects];

    self.choices = [[NSMutableArray alloc] init];
    for(int i = 1; i <= self.maxChoices; i++)
    {
        Choice *newChoice = [[Choice alloc] init];
        newChoice.value = i;
        newChoice.isEnabled = YES;
        newChoice.isAnswer = (i == answer);
        [self.choices addObject:newChoice];
    }
}

#pragma Public Messages
- (void)restartGame
{
    if (self.resetGame)
    {
        [self reinitGame];
        self.resetGame = NO;
    }

    self.numGuesses = 0;
    self.possibleCorrectAnswers = @[@1, @2, @3, @4, @6, @7, @8, @9];
    self.winningNumber = [self getWinningAnswer];
    [self initChoicesWithAnswer:self.winningNumber];
}

- (void)choiceMade:(Choice *)choice
{
    self.numGuesses++;

    if (choice.isAnswer)
    {
        self.numWins++;
        [self restartGame];
    }
}

- (Choice *)choiceAtIndex:(NSUInteger)index
{
    return (index < [self.choices count]) ? self.choices[index] : Nil;
}

- (BOOL)isGameLost
{
    BOOL gameLost = (self.numGuesses >= MAX_GUESSES);
    if (gameLost) self.numLosses++;

    return gameLost;
}

- (BOOL)wasDominated
{
    return (self.numLosses >= MAX_LOSSES);
}

- (BOOL)isDominated
{
    return (self.numWins >= MAX_WINS);
}

#pragma Private Messages
- (NSInteger)getWinningAnswer
{
    NSInteger answer = [[self.possibleCorrectAnswers objectAtIndex:arc4random_uniform([self.possibleCorrectAnswers count])] intValue];
    NSLog(@"Winning Answer: %d", answer);

    return answer;
}

- (void)reinitGame
{
    self.numWins = 0;
    self.numLosses = 0;
}

@end