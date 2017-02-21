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

@end

@implementation QuestionViewController

- (QuestionViewController*)initWithQuestion:(Question *)question{
    if (self = [super initWithNibName:@"QuestionViewController" bundle:nil]) {
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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)quitQuiz:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)answerPressed:(id)sender{
    NSInteger index = [self.answerButtons indexOfObject:sender];
    if (index > -1) {
        self.question.timeTaken = 0.0;
        self.question.answerGiven = index;
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate didAnswerQuestion:self.question];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
