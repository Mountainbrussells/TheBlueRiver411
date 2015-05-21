//
//  BRLocationsViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 2/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRLocationsViewController.h"
#import "BRCustomCellTwo.h"
#import "Area.h"
#import "CoreData+MagicalRecord.h"
// #import "BRDetailsViewController.h"

@interface BRLocationsViewController ()
{
    NSMutableArray *_dataArray;
}

@end

@implementation BRLocationsViewController

@synthesize locationTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    locationTable.delegate = self;
    locationTable.dataSource = self;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArray = [NSMutableArray new];
    
    [self refreshData];
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = self.area.name;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh
- (void) refreshData
{
    [_dataArray removeAllObjects];
    Area *area = self.area;
    NSLog(@"%@", self.area.name);
    NSArray *allRecords = [Location MR_findByAttribute:@"area" withValue:area];
    [_dataArray addObjectsFromArray:allRecords];
    [locationTable reloadData];
    NSLog(@"there are %i Locations once data is refreshed", allRecords.count);
}

# pragma mark - table view delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   //   This is where the count of cells will come from the back end

    
    NSLog(@"there are %i locations", _dataArray.count);
    return _dataArray.count;
    
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BRCustomCellTwo *cell = (BRCustomCellTwo *)[tableView dequeueReusableCellWithIdentifier: @"customCellIdentifier"];
    cell.backgroundColor = [UIColor clearColor];
    
    Location *location = [_dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = location.name;
    cell.bulletDescription.text = location.bulletDescription;
    cell.areaIconView.image = [UIImage imageNamed:@"LocationsImage"];
    
    

    
    
    return cell;
}

//# pragma mark - segue preperations
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showDetails"]) {
//        NSIndexPath *indexPath = [self.locationTable indexPathForSelectedRow];
//        BRDetailsViewController *detailsView = segue.destinationViewController;
//        detailsView.location = [_dataArray objectAtIndex:indexPath.row];
//    }
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
