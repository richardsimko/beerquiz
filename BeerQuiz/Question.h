//
//  Question.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Question : NSObject

@property(nonatomic, retain) NSString *questionText;
@property (nonatomic, retain) NSArray *answers;
@property (nonatomic) int correctAnswer;
@property (nonatomic) NSInteger answerGiven;
@property (nonatomic) double timeTaken;

-(Question*) initWithQuestion:(NSString *) question answers:(NSArray *) answers correct:(int)correct;

-(BOOL) checkAnswer;

@end
