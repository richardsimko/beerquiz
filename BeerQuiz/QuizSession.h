//
//  QuizSession.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface QuizSession : NSObject

-(QuizSession *) initWithQuestions:(NSArray *)questions;

-(Question *)nextQuestion;

@end
