//
//  ViewController.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "MainMenuViewController.h"

#import "QuestionViewController.h"
#import "GameOverViewController.h"
#import "Question.h"
#import "QuizSession.h"

@interface MainMenuViewController ()<QuestionViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *devModeButton;
@property (nonatomic, weak) IBOutlet UIButton *startQuizButton;

@property (nonatomic, weak) IBOutlet UILabel *quizInProgressLabel;

@property (nonatomic, retain) QuizSession *session;

@end

@implementation MainMenuViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.devModeButton.titleLabel.text = NSLocalizedString(@"mainMenu.devMode.button", @"");
    self.startQuizButton.titleLabel.text = NSLocalizedString(@"mainMenu.startQuiz.button", @"");
}

-(IBAction)startQuiz:(id)sender{
    if (sender == self.devModeButton) {
        Question *question = [[Question alloc] initWithQuestion:@"What is the meaning of life?" answers:[NSArray arrayWithObjects: @"1", @"2", @"3", @"42", nil] correct:3];
        Question *question2 = [[Question alloc] initWithQuestion:@"1+1" answers:[NSArray arrayWithObjects: @"1", @"2", @"3", @"42", nil] correct:1];
        self.session = [[QuizSession alloc] initWithQuestions:[NSArray arrayWithObjects:question, question2, nil]];
    } else {
        self.session = [[QuizSession alloc] initWithFilename: @"Quiz"];
    }
    self.quizInProgressLabel.hidden = NO;
    [self presentQuestion:[self.session nextQuestion:nil]];
}

-(void) didAnswerQuestion:(Question *) question {
    Question *nextQuestion = [self.session nextQuestion:question];
    if (nextQuestion) {
        [self presentQuestion:nextQuestion];
    } else {
        self.quizInProgressLabel.hidden = YES;
        GameOverViewController *vc = [[GameOverViewController alloc] initWithSession:self.session.stats];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

-(IBAction)showDeveloperMode:(id)sender{
    self.devModeButton.hidden = NO;
}

-(void) didQuit{
    self.quizInProgressLabel.hidden = YES;
    self.session = nil;
}


-(void) presentQuestion: (Question*) q{
    QuestionViewController *vc = [[QuestionViewController alloc] initWithQuestion:q inSession:self.session];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
