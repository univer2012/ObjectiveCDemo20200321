//
//  SGHReusableHeaderFooterTableViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/20.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGHReusableHeaderFooterTableViewController.h"

@interface SGHReusableHeaderFooterTableViewController ()

@property(nonatomic,strong)NSMutableArray *monthArray;

@property(nonatomic,strong)NSMutableArray *yearArray;

@property(nonatomic,weak)NSTimer *timer;


@end

static NSString *cellIdentifier = @"tableViewCellIdentifier";
static NSString *headerIdentifier = @"tableViewHeaderIdentifier";

@implementation SGHReusableHeaderFooterTableViewController
{
//    NSTimer *_timer;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerIdentifier];
    //test
//    [self.tableView registerClass:[UITableViewHeaderFooterView class] forCellReuseIdentifier:cellIdentifier];
    
    self.yearArray = [@[@"2010年", @"2011年", @"2012年", @"2013年", @"2014年", @"2015年", @"2016年", @"2017年", @"2018年", @"2019年", @"2020年"] mutableCopy];
    self.monthArray = [@[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"] mutableCopy];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(p_timer) userInfo:nil repeats:YES];
}

-(void)p_timer {
    NSLog(@"p_timer");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.yearArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.monthArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    headerView.textLabel.text = self.yearArray[section];
    headerView.contentView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
    headerView.tintColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
    headerView.detailTextLabel.text = @"detailTextLabel";
    return headerView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",self.yearArray[indexPath.section], self.monthArray[indexPath.row]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_timer invalidate];
    
    NSLog(@"_timer: %@",_timer);
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
