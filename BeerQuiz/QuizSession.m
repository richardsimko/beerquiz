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
@property (nonatomic, retain) Stats *stats;

@end

@implementation QuizSession

-(QuizSession *) initWithQuestions:(NSArray *)questions{
    if (self = [super init]) {
        self.questions = questions;
        self.currentQuestion = -1;
        self.stats = [[Stats alloc] init];
    }
    return self;
}

/**
 * Gets the next question in this session and updates the stats with those of the previous one.
 */
-(Question *)nextQuestion:(Question *)previousQuestion {
    if(previousQuestion){
        if ([previousQuestion checkAnswer]) {
            self.stats.correctAnswers++;
        } else if(previousQuestion.timeout) {
            self.stats.missedQuestions++;
        } else {
            self.stats.incorrectAnswers++;
        }
        
        if (previousQuestion.timeTaken < self.stats.fastestResponseTime) {
            self.stats.fastestResponseTime = previousQuestion.timeTaken;
        }
        
        if (previousQuestion.timeTaken > self.stats.slowestResponseTime) {
            self.stats.slowestResponseTime = previousQuestion.timeTaken;
        }
        
        self.stats.totalTimeTaken += previousQuestion.timeTaken;
        self.stats.averageResponseTime = self.stats.totalTimeTaken / self.questions.count;
    }
    self.currentQuestion++;
    if (self.currentQuestion < self.questions.count) {
        Question *nextQuestion = [self.questions objectAtIndex:self.currentQuestion];
        return nextQuestion;
    } else {
        return nil;
    }
}

@end
