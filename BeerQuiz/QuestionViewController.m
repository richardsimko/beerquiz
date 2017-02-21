//
//  QuestionViewController.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@property (nonatomic, retain) Question *question;

@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *answerButtons;

@property (nonatomic, retain) IBOutlet UILabel *questionLabel;

@property (nonatomic, retain) IBOutlet UIButton *fiftyFiftyButton;
@property (nonatomic, retain) IBOutlet UILabel *timeRemainingLabel;
@property (nonatomic, retain) IBOutlet UIButton *plusTimeButton;

@property (nonatomic, retain) NSTimer *updateTimeTimer;
@property (nonatomic, retain) NSTimer *timelimitTimer;

@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval expiryTime;

@end

@implementation QuestionViewController

static const double MAX_TIME = 15.0;

- (QuestionViewController*)initWithQuestion:(Question *)question{
    if (self = [super initWithNibName:@"QuestionViewController" bundle:nil]) {
        if(!question){
            @throw [NSException exceptionWithName:@"InvalidInputException" reason:@"Question must not be nil" userInfo:nil];
        }
        self.question = question;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.questionLabel.text = self.question.questionText;
    for (int i = 0; i < self.question.answers.count; i++) {
        NSString *answerText = [self.question.answers objectAtIndex:i];
        [((UIButton *)[self.answerButtons objectAtIndex:i]) setTitle:answerText forState:UIControlStateNormal];
    }
    self.timeRemainingLabel.text = [NSString stringWithFormat:@"Time left: %.2f", MAX_TIME];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.startTime = [[NSDate date] timeIntervalSince1970];
    self.expiryTime = self.startTime + MAX_TIME;
    self.updateTimeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block: ^(NSTimer *timer){
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        self.timeRemainingLabel.text = [NSString stringWithFormat:@"Time left: %.2f", self.expiryTime - currentTime];
    }];
    self.timelimitTimer = [NSTimer scheduledTimerWithTimeInterval:MAX_TIME repeats:NO block:^(NSTimer *timer){
        [self.updateTimeTimer invalidate];
        for (UIButton *button in self.answerButtons) {
            button.userInteractionEnabled = YES;
        }
        self.question.timeout = YES;
        self.question.answerGiven = -1;
        self.question.timeTaken = MAX_TIME;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate didAnswerQuestion:self.question];
    }];
}

-(IBAction)quitQuiz:(id)sender{
    [self.updateTimeTimer invalidate];
    [self.timelimitTimer invalidate];
    [self.delegate didQuit];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)answerPressed:(id)sender{
    [self.updateTimeTimer invalidate];
    [self.timelimitTimer invalidate];
    NSInteger index = [self.answerButtons indexOfObject:sender];
    if (index > -1) {
        self.question.timeTaken = [[NSDate date] timeIntervalSince1970] - self.startTime;
        self.question.answerGiven = index;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate didAnswerQuestion:self.question];
    }
}


@end
