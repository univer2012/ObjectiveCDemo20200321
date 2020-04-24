//
//  SGH160728ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 16/7/28.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGH160728ViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import <FMDB.h>

@interface SGH160728ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *controllersArray;
@property(nonatomic,strong)NSMutableArray *titlesArray;

@end

@implementation SGH160728ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建database路径
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"test.db"];
    NSLog(@"!!!dbPath = %@",dbPath);
    //2.创建对应路径下数据库
    FMDatabase  *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    if (![db open]) {
        NSLog(@"db open fail");
        return;
    }
    // 4.查询
    NSMutableArray *studentArray = [NSMutableArray array];
    NSString *sql = @"select id, name, age FROM t_student";
    FMResultSet *rs = [db executeQuery:sql];
    while ([rs next]) {
        int id = [rs intForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        int age = [rs intForColumnIndex:2];
        NSDictionary *studentDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:id], @"id", name, @"name", [NSNumber numberWithInt:age], @"age", nil];
        [studentArray addObject:studentDict];
    }
    
    // Do any additional setup after loading the view.
    self.tableView=({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    _controllersArray= [@[
                          @"SGH0802ExpressionViewController",
                          @"SGH0824PresentAndPushOneViewController",
                          @"SGH0824AlertViewViewController",
                          @"SGH1012BecomeHtmlStringViewController",
                          @"SGH1012PlaceholderColorViewController",
                          @"SGH1012GetIvarAndPropertyViewController",
                          @"SGH1013ImageSaveAlbumViewController",
                          @"SGH1013TextViewViewController",
                          @"SGH1101DidScreenshotNotiViewController",
                          @"SGH1103AESViewController",
                          @"SGH16110701ViewController",
                          @"SGH1108UpdateAppViewController",
                          @"SGH1108AppStoreViewController",
                          @"SGH1108ActivityShareViewController",
                          @"SGH1125XMLParserViewController",
                          @"SGH1221SelectedCellsViewController",
                          @"SGH170119CrashRankViewController",
                          @"SGH0713ScreenShotViewController",
                          @"SHSocketStruc0218ViewController",
                          @"SH0227SeniorCampViewController"
                          ] mutableCopy];
    
    self.titlesArray=[@[
                        @"5、iOS正则表达式与判断手机号是否有效实例",
                        @"6、PresentAndPush",
                        @"7、对UIAlertView的各种设置",
                        @"8、string转htmlString并webView显示",
                        @"9、uitextfield_placehold颜色",
                        @"10、获取类的所有变量_值和属性",
                        @"11、截取当前页面并保存到相册",
                        @"12、用UITtextView加载网页字符串",
                        @"13、监听用户截屏",
                        @"14、AES加解密",
                        @"15、openURL Deprecated in iOS10",
                        @"16、IOS_APP弹框检查更新_避免审核被拒",
                        @"17、跳转AppStore的两种方法_应用内和直接跳转",
                        @"18、调用iOS系统自带的分享功能",
                        @"19、使用NSXMLParser解析XML",
                        @"21、tableView多选cell",
                        @"22、iOS_Crash杀手排名",
                        @"23、截屏方案",
                        @"24、Socket基本结构",
                        @"25、高级特训营"
                        ] mutableCopy];
    
    /*用组件隐藏navigationBar，并可以滑动返回
     返回后的控制器的viewWillAppear:方法中，不用设置
     [self.navigationController setNavigationBarHidden:NO animated:YES];
     */
    self.fd_prefersNavigationBarHidden = YES;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //隐藏bar
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    /*
     结论：在tabBarController设置了
     self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
     然后隐藏navigationBar后，无法滑动返回。
     */
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _controllersArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier=@"CellIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text=_titlesArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class cls = NSClassFromString(_controllersArray[indexPath.row]);
    if (cls) {
        [self.navigationController pushViewController:[cls new] animated:YES];
    }
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
