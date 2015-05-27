//
//  BRBugViewController.h
//  AnyRiver411
//
//  Created by Ben Russell on 5/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface BRBugViewController : UIViewController 
@property (nonatomic, strong) Location *location;
@property (weak, nonatomic) IBOutlet UITableView *bugTable;

@end
