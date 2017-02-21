//
//  ViewController.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "MainMenuViewController.h"

#import "QuestionViewController.h"
#import "Question.h"
#import "QuizSession.h"

@interface MainMenuViewController ()<QuestionViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIButton *devModeButton;
@property (nonatomic, weak) IBOutlet UIButton *startQuizButton;

@property (nonatomic, weak) IBOutlet UILabel *quizInProgressLabel;

@property (nonatomic, retain) QuizSession *session;

@end

@implementation MainMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) presentQuestion: (Question*) q{
    QuestionViewController *vc = [[QuestionViewController alloc] initWithQuestion:[self.session nextQuestion]];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(IBAction)startQuiz:(id)sender{
    if (sender == self.devModeButton) {
        NSLog(@"Dev mode");
    } else if(sender == self.startQuizButton){
        NSLog(@"Real mode");
    }
    Question *question = [[Question alloc] initWithQuestion:@"What is the meaning of life?" answers:[NSArray arrayWithObjects: @"1", @"2", @"3", @"42", nil] correct:3];
    self.session = [[QuizSession alloc] initWithQuestions:[NSArray arrayWithObjects:question, nil]];
    self.quizInProgressLabel.hidden = NO;
    [self presentQuestion:[self.session nextQuestion]];
}

-(void) didAnswerQuestion:(Question *) question {
    Question *nextQuestion = [self.session nextQuestion];
    if (nextQuestion) {
        [self presentQuestion:nextQuestion];
    } else {
        self.quizInProgressLabel.hidden = YES;
        NSLog(@"Quiz complete");
    }
}

@end
