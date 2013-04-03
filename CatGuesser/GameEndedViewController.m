//
//  GameEndedViewController.m
//  CatGuesser
//
//  Created by Mike Berlin on 3/27/13.
//  Copyright (c) 2013 Mike Berlin. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "GameEndedViewController.h"
#import "MainViewController.h"

@interface GameEndedViewController ()

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation GameEndedViewController

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

    if (self.wasDominated)
        [self gameWonInit];
    else
        [self gameLostInit];

    // add swipe gestures
    UISwipeGestureRecognizer *oneFingerSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                             action:@selector(oneFingerSwipeDown:)];
    [oneFingerSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:oneFingerSwipeDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)oneFingerSwipeDown:(UITapGestureRecognizer *)recognizer {
    self.parent.game.resetGame = YES;
    [self.parent.game restartGame];
    [self.parent syncUI];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)gameWonInit
{
    self.imgGameOver.image = [UIImage imageNamed:@"businesscat.png"];
    [self playSoundFile:@"winner"];
}

- (void)gameLostInit
{
    self.imgGameOver.image = [UIImage imageNamed:@"anothercat.png"];
    [self playSoundFile:@"loser"];
}

- (void)playSoundFile:(NSString *)soundFilename
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource:soundFilename
                                    ofType:@"mp3"];

    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];

    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                              error:nil];

    [self.audioPlayer play];
}

@end