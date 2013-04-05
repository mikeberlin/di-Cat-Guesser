//
//  GuessingGame.h
//  CatGuesser
//
//  Created by Mike Berlin on 4/2/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Choice.h"

@interface GuessingGame : NSObject

#define MAX_GUESSES 4
#define MAX_LOSSES 4
#define MAX_WINS 3
#define DEFAULT_MAX_CHOICES 9
#define UD_NUM_WINS_KEY @"NumWins"
#define UD_NUM_LOSSES_KEY @"NumLosses"
#define UD_HIGH_SCORES @"HighScores"

@property (nonatomic) NSArray *possibleCorrectAnswers;
@property (nonatomic, strong) NSMutableArray *choices; // of Choices
@property (nonatomic) NSTimeInterval duration;

@property (nonatomic) NSInteger winningNumber;
@property (nonatomic) NSInteger maxChoices;
@property (nonatomic) NSInteger numGuesses;
@property (nonatomic) NSInteger numWins;
@property (nonatomic) NSInteger numLosses;

@property (nonatomic) BOOL resetGame;

- (void)choiceMade:(Choice *)choice;
- (Choice *)choiceAtIndex:(NSUInteger)index;
- (void)restartGame;
- (BOOL)wasDominated;
- (BOOL)isDominated;
- (BOOL)isGameLost;
- (void)startGame;

@end