//
//  QuestionViewController.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Question.h"
#import "QuizSession.h"

@protocol QuestionViewControllerDelegate <NSObject>

-(void)didAnswerQuestion:(Question *) question;
-(void)didQuit;

@end

@interface QuestionViewController : UIViewController

@property (nonatomic, weak) NSObject<QuestionViewControllerDelegate> *delegate;

-(IBAction)quitQuiz:(id)sender;
-(IBAction)answerPressed:(id)sender;
-(IBAction)fiftyFiftyPressed:(id)sender;
-(IBAction)extraTimePressed:(id)sender;

- (QuestionViewController*)initWithQuestion:(Question *)question inSession:(QuizSession *)session;


@end
