//
//  SGH0515AttibuteStringInitViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/15.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0515AttibuteStringInitViewController.h"

static NSString *kCellIndentifier=@"kCellIndentifier";

@interface SGH0515AttibuteStringInitViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
//@property(nonatomic,weak)UITableView *tableView;

@end

@implementation SGH0515AttibuteStringInitViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView  = ({
        UITableView *tableView=[UITableView new];
        [self.view addSubview:tableView];
        tableView.frame=CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        tableView.estimatedRowHeight = 80;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.delegate=self;
        tableView.dataSource=self;
        tableView;
    });
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIndentifier];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1000;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kCellIndentifier];
    NSString *testString = @"<p>盘后分析（5月15日）: 午后市场维持震荡，中央政务区概念受消息刺激集体拉升 盘后分析（5月15日）: 午后市场维持震荡，中央政务区概念受消息刺激集体拉升 盘后分析（5月15日）: 午后市场维持震荡，中央政务区概念受消息刺激集体拉升 盘后分析（5月15日）: 午后市场维持震荡，中央政务区概念受消息刺激集体拉升</p>";
    cell.textLabel.numberOfLines = 0;
    
#if 0
    NSData *summaryData = [testString  dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *muatbleAttrStr=[[NSAttributedString alloc]initWithData:summaryData options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    NSMutableAttributedString *subMuatbleAttrStr = [[muatbleAttrStr attributedSubstringFromRange:NSMakeRange(0, muatbleAttrStr.length)] mutableCopy];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1;//行间距
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [subMuatbleAttrStr addAttributes:@{NSFontAttributeName : cell.textLabel.font, NSForegroundColorAttributeName : cell.textLabel.textColor, NSParagraphStyleAttributeName : paragraphStyle} range:NSMakeRange(0, subMuatbleAttrStr.length)];
    
    cell.textLabel.attributedText = subMuatbleAttrStr;
    
#else
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *summaryData = [testString  dataUsingEncoding:NSUnicodeStringEncoding];
        NSAttributedString *muatbleAttrStr=[[NSAttributedString alloc]initWithData:summaryData options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        
        __block NSMutableAttributedString *subMuatbleAttrStr = [[muatbleAttrStr attributedSubstringFromRange:NSMakeRange(0, muatbleAttrStr.length)] mutableCopy];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 1;//行间距
        paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
        [subMuatbleAttrStr addAttributes:@{NSFontAttributeName : cell.textLabel.font, NSForegroundColorAttributeName : cell.textLabel.textColor, NSParagraphStyleAttributeName : paragraphStyle} range:NSMakeRange(0, subMuatbleAttrStr.length)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           cell.textLabel.attributedText = subMuatbleAttrStr;
        });
    });
    
    
#endif
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}


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
