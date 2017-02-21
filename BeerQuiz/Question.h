//
//  Question.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property(nonatomic, retain, readonly) NSString *questionText;
@property (nonatomic, retain, readonly) NSArray *answers;
@property (nonatomic, readonly) int correctAnswer;
@property (nonatomic) NSInteger answerGiven;
@property (nonatomic) double timeTaken;
@property (nonatomic) BOOL timeout;

-(Question*) initWithQuestion:(NSString *) question answers:(NSArray *) answers correct:(int)correct;

-(BOOL) checkAnswer;

@end
