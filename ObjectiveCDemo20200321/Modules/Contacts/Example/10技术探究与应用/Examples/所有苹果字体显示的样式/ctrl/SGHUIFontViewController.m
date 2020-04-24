//
//  SGHUIFontViewController.m
//  ObjectiveCDemo-16-04-07
//
//  Created by huangaengoln on 16/4/26.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHUIFontViewController.h"

@interface SGHUIFontViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView * tableView;

@end

@implementation SGHUIFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
}

#pragma mark -section  数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    //字体家族总数
    return [[UIFont familyNames] count];
}

#pragma mark -每个section   中的   cell数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //字体家族名称
    NSString *familyName= [[UIFont familyNames] objectAtIndex:section];
    //字体家族包括的字体库总数
    return [[UIFont fontNamesForFamilyName:familyName] count];
}
#pragma mark -header的名字
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //字体家族名称
    return [[UIFont familyNames] objectAtIndex:section];
}



- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    return index;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    //字体家族名称
    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:familyName] objectAtIndex:indexPath.row];
    //    NSLog(@"%@",fontName);
    cell.textLabel.font = [UIFont fontWithName:fontName size:18.0f];
    
    cell.textLabel.text=@"北京30°ABCabc";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", familyName, fontName ];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //字体家族名称
    //    NSString *familyName= [[UIFont familyNames] objectAtIndex:indexPath.section];
    
    //字体家族中的字体库名称
    NSString *fontName  = [[UIFont fontNamesForFamilyName:[[UIFont familyNames] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    NSLog(@"%@",fontName);
    
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
