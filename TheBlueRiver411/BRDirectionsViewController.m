//
//  BRDirectionsViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 3/2/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRDirectionsViewController.h"

@interface BRDirectionsViewController ()

@property (weak, nonatomic) IBOutlet UITextView *directionsView;


@end

@implementation BRDirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.directionsView.text = self.location.directions;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
