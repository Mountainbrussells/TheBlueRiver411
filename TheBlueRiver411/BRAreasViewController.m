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



@end

@implementation BRAreasViewController

@synthesize areaTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    areaTable.delegate = self;
    areaTable.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArray = [NSMutableArray new];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"Anglers411";
    
    
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
