//
//  Stats.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "Stats.h"

@implementation Stats
-(Stats *) init{
    if (self = [super init]) {
        self.slowestResponseTime = DBL_MIN;
        self.fastestResponseTime = DBL_MAX;
    }
    return self;
}
@end
