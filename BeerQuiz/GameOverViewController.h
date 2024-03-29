//
//  GameOverViewController.h
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stats.h"

@interface GameOverViewController : UIViewController <UINavigationBarDelegate>

-(GameOverViewController *)initWithSession:(Stats *) session;

-(IBAction)doneButtonPressed:(id)sender;

@end
