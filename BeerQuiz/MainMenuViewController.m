//
//  ViewController.m
//  BeerQuiz
//
//  Created by Richard Simko on 2017-02-21.
//  Copyright © 2017 Richard Simko. All rights reserved.
//

#import "MainMenuViewController.h"

#import "QuestionViewController.h"

@interface MainMenuViewController ()

@property (nonatomic, weak) IBOutlet UIButton *devModeButton;
@property (nonatomic, weak) IBOutlet UIButton *startQuizButton;

@end

@implementation MainMenuViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)startQuiz:(id)sender{
    if (sender == self.devModeButton) {
        NSLog(@"Dev mode");
    } else if(sender == self.startQuizButton){
        NSLog(@"Real mode");
    }
    QuestionViewController *vc = [[QuestionViewController alloc] initWithNibName:@"QuestionViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
