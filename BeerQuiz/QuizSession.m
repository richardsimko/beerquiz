//
//  QuizSession.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "QuizSession.h"

@interface QuizSession()

@property (nonatomic, retain) NSArray *questions;
@property (nonatomic) NSInteger currentQuestion;

@end

@implementation QuizSession

-(QuizSession *) initWithQuestions:(NSArray *)questions{
    if (self = [super init]) {
        self.questions = questions;
        self.currentQuestion = -1;
    }
    return self;
}

-(Question *)nextQuestion{
    self.currentQuestion++;
    if (self.currentQuestion < self.questions.count - 1) {
        Question *nextQuestion = [self.questions objectAtIndex:self.currentQuestion];
        return nextQuestion;
    } else {
        return nil;
    }
}

@end
