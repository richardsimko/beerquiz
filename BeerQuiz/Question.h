//
//  Question.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject

@property(nonatomic, retain, readonly, nonnull) NSString *questionText;
@property (nonatomic, retain, nonnull, readonly) NSArray *answers;
@property (nonatomic, readonly) NSInteger correctAnswer;
@property (nonnull, readonly, retain) UIImage *questionImage;
@property (nonatomic) NSInteger answerGiven;
@property (nonatomic) double timeTaken;
@property (nonatomic) BOOL timeout;

-(nonnull Question*) initWithQuestion:(nonnull NSString *) question answers:(nonnull NSArray *) answers correct:(NSInteger)correct;
-(nonnull Question*) initWithDictionary:(nonnull NSDictionary *)dictionary;

-(BOOL) checkAnswer;
-(nonnull NSArray *)getFiftyFifty;

@end
