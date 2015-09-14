//
//  BRBugViewController.m
//  AnyRiver411
//
//  Created by Ben Russell on 5/12/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "BRBugViewController.h"
#import "CoreData+MagicalRecord.h"
#import "Bug.h"

@interface BRBugViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



@end

@implementation BRBugViewController
@synthesize bugTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LighterFishnet_scalechange"]];

    
    NSDate *now = [NSDate date];
    
    // You need an NSDateFormatter that will turn a date into a simple string
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        //dateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:now];
    
    bugTable.delegate = self;
    bugTable.dataSource = self;
    
//    UITableView *bugList = [[UITableView alloc] init];
//    self.bugTable = bugList;
//    
//    [self.bugTable registerClass:[UITableViewCell class]
//         forCellReuseIdentifier:@"UITableViewCell"];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _dataArray = [NSMutableArray new];
    
    [self refreshData];
    
}

- (void) refreshData
{
    [_dataArray removeAllObjects];
    
    
    
    
    // Setting current date
    NSDate *currentDate = [NSDate date];
    NSLog(@"This is the current date: %@", currentDate);
    
    // pulling int for current yeear out of current date
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comp = [cal components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = [comp year];
    NSLog(@"This is the current year:%i", currentYear);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    // Setting season date perimeters
    NSDateComponents *comp1 =[[NSDateComponents alloc] init];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 3];
    [comp1 setDay: 15];
    NSDate *begSpring = [calendar dateFromComponents:comp1];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 6];
    [comp1 setDay: 15];
    NSDate *endSpring = [calendar dateFromComponents:comp1];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 6];
    [comp1 setDay: 16];
    NSDate *begSummer = [calendar dateFromComponents:comp1];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 8];
    [comp1 setDay: 31];
    NSDate *endSummer = [calendar dateFromComponents:comp1];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 9];
    [comp1 setDay: 01];
    NSDate *begFall = [calendar dateFromComponents:comp1];
    
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 11];
    [comp1 setDay: 15];
    NSDate *endFall = [calendar dateFromComponents:comp1];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 11];
    [comp1 setDay: 16];
    NSDate *begWinter = [calendar dateFromComponents:comp1];
    
    [comp1 setYear: currentYear];
    [comp1 setMonth: 03];
    [comp1 setDay: 14];
    NSDate *endWinter = [calendar dateFromComponents:comp1];
    
    
    
    
    if ([currentDate compare:begSpring] == NSOrderedDescending && [currentDate compare:endSpring] == NSOrderedAscending) {
        NSLog(@"It is spring");
        NSPredicate *bugFilter = [NSPredicate predicateWithFormat:@"(spring == '1') AND (%K == %@)", @"location", self.location];
        NSArray *bugs = [Bug MR_findAllWithPredicate:bugFilter];
        [_dataArray addObjectsFromArray:bugs];
        NSLog(@"There are %i fall bugs.", _dataArray.count);
        
    }
    
    else if ([currentDate compare:begSummer] == NSOrderedDescending && [currentDate compare:endSummer] == NSOrderedAscending) {
        NSLog(@"It is summer");
        NSPredicate *bugFilter = [NSPredicate predicateWithFormat:@"(summer == '1') AND (%K == %@)", @"location", self.location];
        NSArray *bugs = [Bug MR_findAllWithPredicate:bugFilter];
        [_dataArray addObjectsFromArray:bugs];
        
    }
    
    else if ([currentDate compare:begFall] == NSOrderedDescending && [currentDate compare:endFall] == NSOrderedAscending){
        
        
        NSPredicate *bugFilter = [NSPredicate predicateWithFormat:@"(fall == '1') AND (%K == %@)", @"location", self.location];
        NSArray *bugs = [Bug MR_findAllWithPredicate:bugFilter];
        [_dataArray addObjectsFromArray:bugs];
        NSLog(@"There are %i fall bugs.", _dataArray.count);
        
    }
    
    else if ([currentDate compare:begWinter] == NSOrderedDescending || [currentDate compare:endWinter] == NSOrderedAscending){
        NSLog(@"it is winter");
        NSPredicate *bugFilter = [NSPredicate predicateWithFormat:@"(winter == '1') AND (%K == %@)", @"location", self.location];
        NSArray *bugs = [Bug MR_findAllWithPredicate:bugFilter];
        [_dataArray addObjectsFromArray:bugs];
    }
    
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
    NSLog(@"The table view will have %i sections", _dataArray.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    Bug *bug = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = bug.name;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

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
