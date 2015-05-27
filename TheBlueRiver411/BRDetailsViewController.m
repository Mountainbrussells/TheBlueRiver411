//
//  BRDetailsViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 2/25/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRDetailsViewController.h"
#import "BRDirectionsViewController.h"
#import "BRDescriptionViewController.h"
#import "BRBugViewController.h"


@interface BRDetailsViewController ()

@end

@implementation BRDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBarController *tabBarController = self.tabBarController;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = self.location.name;
    NSLog(@"The Details View Controllers Location is %@", self.location.name);
    BRDescriptionViewController *dvc = [[self viewControllers] objectAtIndex:0];
    dvc.location = self.location;
    NSLog(@"The Description  View Controllers Location is %@", dvc.location.name);
    
    BRDirectionsViewController *dirvc = [[self viewControllers] objectAtIndex:1];
    dirvc.location = self.location;
    
    BRBugViewController *bvc = [[self viewControllers] objectAtIndex:2];
    bvc.location = self.location;
    
    
    
}



//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"tab"])
//    {
//        UITabBarController *tabbar = segue.destinationViewController;
//        BRDescriptionViewController *descView = [tabbar.viewControllers objectAtIndex:0];
//        NSLog(@"this is my location %@, before segue ", self.location.name);
//        descView.location = self.location;
//        
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
