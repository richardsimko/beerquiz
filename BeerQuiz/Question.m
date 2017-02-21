//
//  Question.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "Question.h"
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
        self.answers = [dictionary objectForKey:@"answers"];
        self.correctAnswer = ((NSNumber *)[dictionary objectForKey:@"correctAnswer"]).integerValue;
    }
    return self;
}

-(BOOL) checkAnswer{
    return self.answerGiven != -1 && self.answerGiven < self.answers.count && self.answerGiven == self.correctAnswer;
}

/**
 * Gets the answers that should remain after a 50-50 has been played.
 */
-(NSArray *)getFiftyFifty{
    NSMutableArray *output = [[NSMutableArray alloc] init];
    //    This assumes that we always have an even number of answers
    for (int i = 0; i < self.answers.count / 2; i++) {
        int randomIndex = arc4random_uniform((int) self.answers.count - 1);
        // Make sure we never generate the same number twice and that it's not the answer index
        while ([output indexOfObject:[NSNumber numberWithInt:randomIndex]] != NSNotFound || randomIndex == self.correctAnswer) {
            randomIndex = arc4random_uniform((int) self.answers.count - 1);
        }
        [output addObject:[NSNumber numberWithInt:randomIndex]];
    }
    return output;
}

@end
