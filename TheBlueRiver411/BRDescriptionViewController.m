//
//  BRDescriptionViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 2/26/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRDescriptionViewController.h"

@interface BRDescriptionViewController ()

@property (weak, nonatomic) IBOutlet UITextView *descriptionText;


@end

@implementation BRDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // For some reason this has to happen here.
    NSLog(@"this is also my location %@", self.location.name);
    self.descriptionText.text = self.location.desc;
    self.descriptionText.backgroundColor = [UIColor clearColor];
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
