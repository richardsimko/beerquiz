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
@property (nonatomic) BOOL fiftyFiftySpent;
@property (nonatomic) BOOL extraTimeSpent;
@property (nonatomic, readonly) NSInteger currentQuestion;

-(QuizSession *) initWithQuestions:(NSArray *)questions;
-(QuizSession *) initWithFilename: (NSString *) filename;
-(Question *)nextQuestion:(Question*)previousQuestion;

@end

FOUNDATION_EXPORT int const NUM_QUESTIONS;
