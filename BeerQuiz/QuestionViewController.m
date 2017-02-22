//
//  QuestionViewController.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "QuestionViewController.h"
#import "DisablableButton.h"

@interface QuestionViewController ()

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) QuizSession *session;

@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *answerButtons;

@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UIImageView *questionImageView;

@property (nonatomic, retain) IBOutlet DisablableButton *fiftyFiftyButton;
@property (nonatomic, retain) IBOutlet UILabel *timeRemainingLabel;
@property (nonatomic, retain) IBOutlet DisablableButton *extraTimeButton;

@property (nonatomic, retain) NSTimer *updateTimeTimer;
@property (nonatomic, retain) NSTimer *timelimitTimer;

@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval expiryTime;

@end

@implementation QuestionViewController

static const double MAX_TIME = 15.0;
static const double EXTRA_TIME = 10.0;

- (QuestionViewController*)initWithQuestion:(Question *)question inSession:(QuizSession *)session{
    if (self = [super initWithNibName:@"QuestionViewController" bundle:nil]) {
        if(!question){
            @throw [NSException exceptionWithName:@"InvalidInputException" reason:@"Question must not be nil" userInfo:nil];
        }
        self.session = session;
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
    if(self.session.fiftyFiftySpent){
        [self.fiftyFiftyButton disable];
    }
    if (self.session.extraTimeSpent) {
        [self.extraTimeButton disable];
    }
    if (self.question.questionImage) {
        self.questionLabel.hidden = YES;
        self.questionImageView.image = self.question.questionImage;
    }
    // Do some UI setup that can't be done in IB
    for (UIButton *button in self.answerButtons) {
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    self.timeRemainingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"question.timeLeft.label", @""), MAX_TIME];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    self.startTime = [[NSDate date] timeIntervalSince1970];
    self.expiryTime = self.startTime + MAX_TIME;
    
    self.updateTimeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block: ^(NSTimer *timer){
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        self.timeRemainingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"question.timeLeft.label", @""), self.expiryTime - currentTime];
    }];
    
    [self startExpiryTimer];
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
    [self finishQuestion:index];
}

-(IBAction)fiftyFiftyPressed:(id)sender{
    NSArray *removeIndices = [self.question getFiftyFifty];
    self.session.fiftyFiftySpent = YES;
    [self.fiftyFiftyButton disable];
    for (NSNumber *num in removeIndices) {
        ((UIButton *)[self.answerButtons objectAtIndex:num.integerValue]).hidden = YES;
    }
}

-(IBAction)extraTimePressed:(id)sender{
    self.expiryTime += EXTRA_TIME;
    self.session.extraTimeSpent = YES;
    [self.extraTimeButton disable];
    [self startExpiryTimer];
}

-(void) startExpiryTimer{
    [self.timelimitTimer invalidate];
    self.timelimitTimer = [[NSTimer alloc] initWithFireDate:[NSDate dateWithTimeIntervalSince1970:self.expiryTime] interval:0 repeats:NO block:^(NSTimer *timer){
        [self.updateTimeTimer invalidate];
        for (UIButton *button in self.answerButtons) {
            button.userInteractionEnabled = YES;
        }
        self.question.timeout = YES;
        [self finishQuestion:-1];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timelimitTimer forMode:NSDefaultRunLoopMode];
}

-(void) finishQuestion:(NSInteger) index{
    self.question.timeTaken = [[NSDate date] timeIntervalSince1970] - self.startTime;
    self.question.answerGiven = index;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate didAnswerQuestion:self.question];
}


@end
