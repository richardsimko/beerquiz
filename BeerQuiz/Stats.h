//
//  Stats.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stats : NSObject

@property (nonatomic) NSInteger correctAnswers;
@property (nonatomic) NSInteger incorrectAnswers;
@property (nonatomic) NSInteger missedQuestions;
@property (nonatomic) double averageResponseTime;
@property (nonatomic) double fastestResponseTime;
@property (nonatomic) double slowestResponseTime;
@property (nonatomic) double totalTimeTaken;

@end
