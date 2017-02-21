//
//  ShufflingArray.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "ShufflingArray.h"

@implementation NSMutableArray (Shuffling)


//Shamelessly grabbed from Stackoverflow http://stackoverflow.com/a/56656/1091402
- (void)shuffle
{
    NSUInteger count = self.count;
    if (count <= 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
