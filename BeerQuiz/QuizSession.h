//
//  QuizSession.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"
#import "Stats.h"

@interface QuizSession : NSObject

@property (nonatomic, readonly, retain) Stats *stats;

-(QuizSession *) initWithQuestions:(NSArray *)questions;
-(Question *)nextQuestion:(Question*)previousQuestion;

@end
