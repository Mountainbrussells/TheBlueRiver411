//
//  BRCustomCell.h
//  
//
//  Created by Ben Russell on 12/3/14.
//
//

#import <UIKit/UIKit.h>

@interface BRCustomCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *bulletDescription;
@property (nonatomic, weak) IBOutlet UIImageView *areaIconView;

@end
