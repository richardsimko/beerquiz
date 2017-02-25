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

-(void)didFinishQuiz;
-(void)didQuit;

@end

@interface QuestionViewController : UIViewController <UINavigationBarDelegate>

@property (nonatomic, weak) NSObject<QuestionViewControllerDelegate> *delegate;

-(IBAction)quitQuiz:(id)sender;
-(IBAction)answerPressed:(id)sender;
-(IBAction)fiftyFiftyPressed:(id)sender;
-(IBAction)extraTimePressed:(id)sender;

- (QuestionViewController*)initWithSession:(QuizSession *)session;


@end
