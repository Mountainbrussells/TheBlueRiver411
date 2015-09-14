//
//  BRAreasViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 1/28/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRAreasViewController.h"
#import "BRCustomCell.h"
#import "Area.h"
#import "CoreData+MagicalRecord.h"
#import "BRLocationsViewController.h"


@interface BRAreasViewController ()
{
    NSMutableArray *_dataArray;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *infoButton;


@end

@implementation BRAreasViewController

@synthesize areaTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    areaTable.delegate = self;
    areaTable.dataSource = self;
    
    [self.areaTable setBackgroundView:nil];
    [self.areaTable setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]]];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(194/255.0) green:(77/255.0) blue:(1/255.0) alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:1];
    
    self.infoButton.tintColor = [UIColor whiteColor];
    [self.areaTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArray = [NSMutableArray new];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"BlueRiver411";
    
    
    [self refreshData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh
- (void) refreshData
{
    [_dataArray removeAllObjects];
    NSArray *allRecords = [Area MR_findAll];
    [_dataArray addObjectsFromArray:allRecords];
    [areaTable reloadData];
     NSLog(@"there are %i areas once data is refreshed", _dataArray.count);
}

# pragma mark - table view delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //  This is where the count of cells will come from the back end
    NSLog(@"there are %i areas", _dataArray.count);
    return _dataArray.count;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // Get width of cell
    int cellWidth = cell.bounds.size.width;
    
    // SETTING UP A UIView IN ORDER TO CREATE ILLUSION OF SEPERATION BETWEEN CELLS
    cell.contentView.backgroundColor = [UIColor clearColor];
    UIView *clearRoundedCornerView = [[UIView alloc] initWithFrame:CGRectMake(10,5,(cellWidth-10),105)];
    clearRoundedCornerView.backgroundColor = [UIColor clearColor];
    clearRoundedCornerView.layer.masksToBounds = YES;
    clearRoundedCornerView.layer.cornerRadius = 3.0;
    clearRoundedCornerView.layer.shadowOffset = CGSizeMake(-1, 1);
    clearRoundedCornerView.layer.shadowOpacity = 0.5;
    
    // Set up Mask with 2 rounded corners
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:clearRoundedCornerView.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(20.0, 20.0)];
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    clearRoundedCornerView.layer.mask = cornerMaskLayer;
    
    // Make a transparent, stroked laker which will display the stroke
    CAShapeLayer *strokeLayer = [CAShapeLayer layer];
    strokeLayer.path = path.CGPath;
    strokeLayer.fillColor = [UIColor clearColor].CGColor;
    strokeLayer.strokeColor = [UIColor colorWithRed:(194/255.0) green:(77/255.0) blue:(1/255.0) alpha:1].CGColor;
    strokeLayer.lineWidth = 5.0;
    
    // Transparent view that will contain the stroke layer
    UIView *strokeView = [[UIView alloc] initWithFrame:clearRoundedCornerView.bounds];
    strokeView.userInteractionEnabled = NO; // in case your container view contains controls
    [strokeView.layer addSublayer:strokeLayer];
    
    [clearRoundedCornerView addSubview:strokeView];
    
    
    [cell.contentView addSubview:clearRoundedCornerView];
    [cell.contentView sendSubviewToBack:clearRoundedCornerView];
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BRCustomCell *cell = (BRCustomCell *)[tableView dequeueReusableCellWithIdentifier: @"customCellIdentifier"];
    cell.backgroundColor = [UIColor clearColor];
    
    Area *area = [_dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = area.name;
    cell.bulletDescription.text = area.bulletDescription;
    cell.areaIconView.image = [UIImage imageNamed:@"LocationsImage"];
    
    
    
    return cell;
}

# pragma mark - segue preperations

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLocations"]) {
        NSIndexPath *indexPath = [self.areaTable indexPathForSelectedRow];
        BRLocationsViewController *locationsView = segue.destinationViewController;
        locationsView.area = [_dataArray objectAtIndex:indexPath.row];
    }
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
