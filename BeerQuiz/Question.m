//
//  Question.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "Question.h"
#import "ShufflingArray.h"
#include <stdlib.h>

@interface Question()

@property (nonatomic, retain) NSString *questionText;
@property (nonatomic, retain) NSArray *answers;
@property (nonatomic) NSInteger correctAnswer;
@property (nonnull, retain) UIImage *questionImage;

@end

@implementation Question

-(Question *) init{
    if (self = [super init]) {
        self.answerGiven = -1;
    }
    return self;
}

-(Question*) initWithQuestion:(NSString *) question answers:(NSArray *) answers correct:(NSInteger)correct{
    if (self = [self init]) {
        self.questionText = question;
        self.answers = answers;
        self.correctAnswer = correct;
        NSMutableArray *mutableAnswers = [self.answers mutableCopy];
        NSString *correctAnswer = [self.answers objectAtIndex:self.correctAnswer];
        [mutableAnswers shuffle];
        self.correctAnswer = [mutableAnswers indexOfObject:correctAnswer];
        self.answers = [NSArray arrayWithArray:mutableAnswers];
    }
    return self;
}

-(Question*) initWithDictionary:(NSDictionary *)dictionary{
    if (self = [self init]) {
        NSString *imageName = [dictionary objectForKey:@"questionImage"];
        NSString *imageNameWithoutExtension = [imageName stringByDeletingPathExtension];
        if (imageName) {
            self.questionImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageNameWithoutExtension ofType:[imageName pathExtension]]];
        }
        self.questionText = [dictionary objectForKey:@"question"];
        NSMutableArray *answers = [[dictionary objectForKey:@"answers"] mutableCopy];
        self.correctAnswer = ((NSNumber *)[dictionary objectForKey:@"correctAnswer"]).integerValue;
        NSString *correctAnswer = [answers objectAtIndex:self.correctAnswer];
        [answers shuffle];
        self.correctAnswer = [answers indexOfObject:correctAnswer];
        self.answers = [NSArray arrayWithArray:answers];
    }
    return self;
}

-(BOOL) checkAnswer{
    return self.answerGiven != -1 && self.answerGiven < self.answers.count && self.answerGiven == self.correctAnswer;
}

/**
 * Gets the answers that should be removed after a 50-50 has been played.
 */
-(NSArray *)getFiftyFifty{
    NSMutableArray *output = [[NSMutableArray alloc] init];
    NSMutableArray *answers = [self.answers mutableCopy];
    [answers removeObjectAtIndex:self.correctAnswer];
    //    This assumes that we always have an even number of answers
    for (int i = 0; i < self.answers.count / 2; i++) {
        // Pick a random index of the remaining answers
        int randomIndex = arc4random_uniform((int) answers.count);
        [output addObject:[answers objectAtIndex:randomIndex]];
        [answers removeObjectAtIndex:randomIndex];
    }
    // Translate the answers back to indices and return them
    for (int i = 0; i < output.count; i++) {
        [output setObject:[NSNumber numberWithInteger:[self.answers indexOfObject:[output objectAtIndex:i]]] atIndexedSubscript:i];
    }
    return output;
}

@end
