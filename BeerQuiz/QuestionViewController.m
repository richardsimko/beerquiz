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

@property (nonatomic, retain) QuizSession *session;

@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *answerButtons;

@property (nonatomic, retain) IBOutlet UINavigationItem *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *questionLabel;
@property (nonatomic, retain) IBOutlet UIImageView *questionImageView;

@property (nonatomic, retain) IBOutlet UIButton *fiftyFiftyButton;
@property (nonatomic, retain) IBOutlet UILabel *timeRemainingLabel;
@property (nonatomic, retain) IBOutlet UIButton *extraTimeButton;

@property (nonatomic, retain) NSTimer *updateTimeTimer;
@property (nonatomic, retain) NSTimer *timelimitTimer;

@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic) NSTimeInterval expiryTime;

@end

@implementation QuestionViewController

static const double MAX_TIME = 15.0;
static const double EXTRA_TIME = 10.0;

- (QuestionViewController*)initWithSession:(QuizSession *)session{
    if (self = [super initWithNibName:@"QuestionViewController" bundle:nil]) {
        self.session = session;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do some UI setup that can't be done in IB
    for (UIButton *button in self.answerButtons) {
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.titleLabel.numberOfLines = 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.session addObserver:self forKeyPath:NSStringFromSelector(@selector(currentQuestionObject)) options:0 context:nil];
    [self.session nextQuestion];
}

-(UIBarPosition) positionForBar:(id<UIBarPositioning>)bar{
    return UIBarPositionTopAttached;
}

-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.session && [keyPath isEqualToString:NSStringFromSelector(@selector(currentQuestionObject))]) {
        // Prevent infinte event loops when setting the value to nil since the previous value is NULL and NULL != nil
        if (self.session.currentQuestionObject == nil) {
            [self.session removeObserver:self forKeyPath:NSStringFromSelector(@selector(currentQuestionObject))];
        }
        [self presentQuestion:self.session.currentQuestionObject];
    }
}

-(IBAction)quitQuiz:(id)sender{
    [self.updateTimeTimer invalidate];
    [self.timelimitTimer invalidate];
    [self.session removeObserver:self forKeyPath:NSStringFromSelector(@selector(currentQuestionObject))];
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
    NSArray *removeIndices = [self.session.currentQuestionObject getFiftyFifty];
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
        self.session.currentQuestionObject.timeout = YES;
        [self finishQuestion:-1];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timelimitTimer forMode:NSDefaultRunLoopMode];
}

-(void) finishQuestion:(NSInteger) index{
    self.session.currentQuestionObject.timeTaken = [[NSDate date] timeIntervalSince1970] - self.startTime;
    self.session.currentQuestionObject.answerGiven = index;
    [self.session nextQuestion];
}

-(void) presentQuestion: (Question *) question {
    if (!self.session.currentQuestionObject) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate didFinishQuiz];
        return;
    }
    self.startTime = [[NSDate date] timeIntervalSince1970];
    self.expiryTime = self.startTime + MAX_TIME;
    self.updateTimeTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 repeats:YES block: ^(NSTimer *timer){
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        self.timeRemainingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"question.timeLeft.label", @""), self.expiryTime - currentTime];
    }];
    self.titleLabel.title = [NSString stringWithFormat:NSLocalizedString(@"question.title.label", @""), self.session.currentQuestion + 1, NUM_QUESTIONS];
    
    if (self.session.currentQuestionObject.questionImage) {
        self.questionLabel.hidden = YES;
        self.questionImageView.hidden = NO;
        self.questionImageView.image = self.session.currentQuestionObject.questionImage;
    } else {
        self.questionLabel.hidden = NO;
        self.questionImageView.hidden = YES;
        self.questionLabel.text = self.session.currentQuestionObject.questionText;
    }
    for (int i = 0; i < self.session.currentQuestionObject.answers.count; i++) {
        NSString *answerText = [self.session.currentQuestionObject.answers objectAtIndex:i];
        UIButton *answerButton = ((UIButton *)[self.answerButtons objectAtIndex:i]);
        answerButton.hidden = NO;
        [answerButton setTitle:answerText forState:UIControlStateNormal];
    }
    self.timeRemainingLabel.text = [NSString stringWithFormat:NSLocalizedString(@"question.timeLeft.label", @""), MAX_TIME];
    [self startExpiryTimer];
}


@end
