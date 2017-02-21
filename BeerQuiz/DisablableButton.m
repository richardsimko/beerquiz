//
//  DisablableButton.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "DisablableButton.h"

@implementation DisablableButton

-(void)disable{
    self.userInteractionEnabled = NO;
    self.tintColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.3];
}

@end
