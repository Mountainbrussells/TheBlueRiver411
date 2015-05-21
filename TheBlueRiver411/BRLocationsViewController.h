//
//  BRLocationsViewController.h
//  AnyRiver411
//
//  Created by Ben Russell on 2/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Area.h"
#import "Location.h"


@interface BRLocationsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Area *area;
@property (weak, nonatomic) IBOutlet UITableView *locationTable;


@end
