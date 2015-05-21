//
//  ViewController.m
//  TheBlueRiver411
//
//  Created by Ben Russell on 5/19/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "ViewController.h"

#import "Area.h"
#import "Location.h"
#import "Bug.h"

#import "CoreData+MagicalRecord.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *allRecords = [Area MR_findAll];
    
    NSLog(@"There are %lu areas", (unsigned long)allRecords.count);
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray *allRecords = [Area MR_findAll];
    
    NSLog(@"There are %lu areas", (unsigned long)allRecords.count);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
