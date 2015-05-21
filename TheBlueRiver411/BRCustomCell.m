//
//  BRCustomCell.m
//  
//
//  Created by Ben Russell on 12/3/14.
//
//

#import "BRCustomCell.h"

@implementation BRCustomCell

- (void)installSelectedBackgroundView{
    
    UIView *bgCustomView = [[UIView alloc] initWithFrame:CGRectMake(10,10,310,110)];
    bgCustomView.backgroundColor = [UIColor lightGrayColor];
    bgCustomView.layer.masksToBounds = YES;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectOffset(bgCustomView.bounds, 10, 10) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    bgCustomView.layer.mask = cornerMaskLayer;
    self.selectedBackgroundView = bgCustomView;
    [self setSelected:YES animated:YES];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self installSelectedBackgroundView];
    }
    return self;
}- (void)awakeFromNib {
    [super awakeFromNib];
    [self installSelectedBackgroundView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
