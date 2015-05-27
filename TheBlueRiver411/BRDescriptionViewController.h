//
//  BRDescriptionViewController.h
//  AnyRiver411
//
//  Created by Ben Russell on 2/26/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@protocol childViewControllerDelegate



@end

@interface BRDescriptionViewController : UIViewController

@property (nonatomic, strong) Location *location;

@end
