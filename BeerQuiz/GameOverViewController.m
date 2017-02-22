//
//  GameOverViewController.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "GameOverViewController.h"


@interface GameOverViewController ()

@property (nonatomic, retain) IBOutlet UILabel *correctLabel;
@property (nonatomic, retain) IBOutlet UILabel *inCorrectLabel;
@property (nonatomic, retain) IBOutlet UILabel *skippedLabel;
@property (nonatomic, retain) IBOutlet UILabel *totalTimeTakenLabel;
@property (nonatomic, retain) IBOutlet UILabel *avgResponseTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *fastestQuestionLabel;
@property (nonatomic, retain) IBOutlet UILabel *slowestQuestionLabel;

@property( nonatomic, retain) Stats *stats;

@end

@implementation GameOverViewController

-(GameOverViewController *)initWithSession:(Stats *) stats{
    if (self = [super initWithNibName:@"GameOverViewController" bundle:nil]) {
        if(!stats){
            @throw [NSException exceptionWithName:@"InvalidInputException" reason:@"Stats must not be nil" userInfo:nil];
        }
        self.stats = stats;
    }
    return self;
}

-(void) viewDidLoad{
    [super viewDidLoad];
    self.correctLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.correctCount.label", @""), (long)self.stats.correctAnswers];
    self.inCorrectLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.incorrectCount.label", @""), (long)self.stats.incorrectAnswers];
    self.skippedLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.unansweredCount.label", @""), (long)self.stats.missedQuestions];
    self.avgResponseTimeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.averageTime.label", @""), self.stats.averageResponseTime];
    self.slowestQuestionLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.slowestAnswer.label", @""), self.stats.slowestResponseTime];
    self.fastestQuestionLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.fastestAnswer.label", @""), self.stats.fastestResponseTime];
    self.totalTimeTakenLabel.text = [NSString stringWithFormat:NSLocalizedString(@"gameover.totalTime.label", @""), self.stats.totalTimeTaken];
}

-(IBAction)doneButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIBarPosition) positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

@end
