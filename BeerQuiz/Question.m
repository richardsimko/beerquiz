//
//  Question.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "Question.h"

@interface Question()

@property (nonatomic, retain) NSString *questionText;
@property (nonatomic, retain) NSArray *answers;
@property (nonatomic) int correctAnswer;

@end

@implementation Question

-(Question*) initWithQuestion:(NSString *) question answers:(NSArray *) answers correct:(int)correct{
    if (self = [super init]) {
        self.questionText = question;
        self.answers = answers;
        self.correctAnswer = correct;
        self.answerGiven = -1;
    }
    return self;
}

-(BOOL) checkAnswer{
    return self.answerGiven != -1 && self.answerGiven < self.answers.count && self.answerGiven == self.correctAnswer;
}

@end
