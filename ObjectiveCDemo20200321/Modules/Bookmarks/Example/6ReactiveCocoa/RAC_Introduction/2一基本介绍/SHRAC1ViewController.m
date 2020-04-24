//
//  SHRAC1ViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/16.
//  Copyright © 2019 huangaengoln. All rights reserved.
//
/*
 * 来自：[RAC(ReactiveCocoa)介绍（一）——基本介绍](https://www.jianshu.com/p/74f1ea777017)
 */
#import "SHRAC1ViewController.h"
#import "SGHCellModel.h"

@interface SHRAC1ViewController ()<UITextFieldDelegate, UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *sectionTitle;

@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) IBOutlet UITextField *testTextField;

@end

@implementation SHRAC1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self RACSequence];
//    [self RACBase];
//    [self RAC_filter];
//    [self RAC_ignoreValue_ignore];
//    [self RAC_distinctUntilChanged];
    
//    [self p_observe];
    
//    [self p_define];
    
    self.dataArray=@[].mutableCopy;
    self.sectionTitle=@[].mutableCopy;
    
    //section 1
    NSArray *tempClassNameArray=@[
        @"normalButton_targetAction",
        @"RACButton_targetAction",
        @"KVO_method",
        @"RAC_KVO",
        @"RACTextFieldDelegate",
        @"RACNotification",
        @"RACTimer",
        @"RACSequence",
        @"RACBase",
        @"weakStrong",
    ];
    NSArray *tempTitleArray=@[
        @"1.UIButton的target-action响应模式",
        @"1-2.使用rac_signalForControlEvents:",
        @"2.传统的KVO监听方式",
        @"2-2.RAC的KVO方式",
        @"3.RAC的delegate代理实现方式",
        @"4.RAC的Notification通知实现方式",
        @"5.RAC的定时器timer的实现方式",
        @"6.RAC的数组与字典的使用",
        @"7.RAC基本使用方法与流程",
        @"8.使用weakify和 strongify解决block的循环引用",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC(ReactiveCocoa)介绍（一）——基本介绍"];
    
    //section 2
    tempClassNameArray = @[
        @"RAC_flattenMap",
        @"RAC_map",
    ];
    tempTitleArray = @[
        @"1.flattenMap的使用",
        @"2.map的使用",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC(ReactiveCocoa)介绍（二）——map映射"];
    //section 3
    tempClassNameArray = @[
        @"RAC_filter",
        @"RAC_ignore",
        @"RAC_ignoreValues",
        @"RAC_distinctUntilChanged",
    ];
    tempTitleArray = @[
        @"1.filter-信号过滤的使用",
        @"2.ignore的使用-忽略字符串「1」",
        @"3.ignoreValues-忽略所有的Values，所以不会打印",
        @"4.distinctUntilChanged-忽略相同的值",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC(ReactiveCocoa)介绍（三）——信号过滤"];
    //section 4
    tempClassNameArray = @[
        @"p_subject",
    ];
    tempTitleArray = @[
        @"1.RACSubject的使用",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"https://www.jianshu.com/p/9793429acac7"];
    //section 5
    tempClassNameArray = @[
        @"p_observe",
    ];
    tempTitleArray = @[
        @"1.KVO的使用",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC(ReactiveCocoa)介绍（八）——KVO销毁"];
    //section 6
    tempClassNameArray = @[
        @"p_define",
    ];
    tempTitleArray = @[
        @"1.宏定义@weakify和@strongify",
    ];
    [self p_addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"RAC(ReactiveCocoa)介绍（十一）——RAC宏定义"];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.tableView = ({
        UITableView *tableView=[UITableView new];
        tableView.frame = CGRectZero;
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
        tableView;
    });
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.testTextField.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
    
    [self.tableView reloadData];
}


//MARK: RAC(ReactiveCocoa)介绍（十一）——RAC宏定义
- (void)p_define {
    @weakify(self);         //备注：
    [[self.testTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        //过滤判断条件
        @strongify(self)    //备注：
        if (self.testTextField.text.length >= 6) {
            self.testTextField.text = [self.testTextField.text substringToIndex:6];
            self.testLabel.text = @"已经到6位了";
            self.testLabel.textColor = UIColor.redColor;
        }
        return value.length <= 6;
        
    }] subscribeNext:^(NSString * _Nullable x) {
        //订阅逻辑区域
        NSLog(@"filter过滤后的订阅内容：%@",x);
    }];
}



//MARK: RAC(ReactiveCocoa)介绍（八）——KVO销毁
- (void)p_observe {
    [RACObserve(self.testLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
//MARK:RAC(ReactiveCocoa)介绍（四）——流程分析
//[RAC(ReactiveCocoa)介绍（四）——流程分析](https://www.jianshu.com/p/9793429acac7)
- (void)p_subject {
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //3.发送信号
    [subject sendNext:@"this is a RACSubject"];
}

//MARK: RAC(ReactiveCocoa)介绍（三）——信号过滤
//MARK: 4.distinctUntilChanged-忽略相同的值
- (void)RAC_distinctUntilChanged {
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"distinctUntilChanged:%@",x);
    }];
    [subject sendNext:@1111];
    [subject sendNext:@2222];
    [subject sendNext:@2222];
}

//MARK:3.ignoreValues-忽略所有的Values，所以不会打印
/*
 ignoreValue与ignore:
 1. ignoreValue与ignore都是基于filter方法封装的。
 2. ignoreValue是直接将指定的信号全部过滤掉，筛选条件全部为NO，将所有信号变为空信号。
 3. ignore是将符合指定字符串条件的信号过滤掉。
 */
- (void)RAC_ignoreValues {
    [[self.testTextField.rac_textSignal ignoreValues] subscribeNext:^(id  _Nullable x) {
        ////将self.testTextField的所有textSignal全部过滤掉
        NSLog(@"ignoreValues:%@",x);        // --> 不会执行
    }];
}
//MARK:2.ignore的使用-忽略字符串「1」
-(void)RAC_ignore {
    [[self.testTextField.rac_textSignal ignore:@"1"] subscribeNext:^(NSString * _Nullable x) {
        //将self.testTextField的textSignal中字符串为指定条件的信号过滤掉
        NSLog(@"ignore:%@",x);      //-->只忽略字符串「1」，不会忽略字符串「12」、「123」等
    }];
}


//MARK:1.filter-信号过滤的使用
//1.filter方法：
- (void)RAC_filter {
    @weakify(self)
    [[self.testTextField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        @strongify(self)
        //过滤判断条件
        if (self.testTextField.text.length >= 6) {
            self.testTextField.text = [self.testTextField.text substringToIndex:6];
            self.testLabel.text = @"已经到6位了";
            self.testLabel.textColor = [UIColor redColor];
        }
        return value.length <= 6;
    }] subscribeNext:^(NSString * _Nullable x) {
        //订阅逻辑区域
        NSLog(@"filter过滤后的订阅内容：%@",x);
    }];
}

//MARK: RAC(ReactiveCocoa)介绍（二）——map映射
//MARK:1.flattenMap的使用
//flattenMap
//flattenMap作用：把原信号的内容映射成一个新信号，并return返回给一个RACStream类型数据。实际上是根据前一个信号传递进来的参数重新建立了一个信号，这个参数，可能会在创建信号的时候用到，也有可能用不到。

- (void)RAC_flattenMap {
    
    [[self.testTextField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {

        //自定义返回内容
        return [RACSignal return:[NSString stringWithFormat:@"自定义返回信号：%@",value]];
        
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
//MARK:2.map的使用
//map
//map作用：是将原信号的值自定义为新的值，不需要再返回RACStream类型，value为源信号的内容，将value处理好的内容直接返回即可。map方法将会创建一个一模一样的信号，只修改其value。
- (void)RAC_map {
    [[self.testTextField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"map自定义：%@",value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}



//MARK:RAC(ReactiveCocoa)介绍（一）——基本介绍
//[RAC(ReactiveCocoa)介绍（一）——基本介绍](https://www.jianshu.com/p/74f1ea777017)

//MARK: 1.UIButton的target-action响应模式
- (void)normalButton_targetAction {
    [self.testButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapAction:(UIButton *)sender {
    NSLog(@"按钮点击了");
    NSLog(@"%@",sender);
}

//MARK: 1-2.使用rac_signalForControlEvents:
- (void)RACButton_targetAction {
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         NSLog(@"RAC按钮点击了");
         NSLog(@"%@",x);
     }];
}
//MARK: Label
- (void)RACLabel_action {
    self.testLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [self.testLabel addGestureRecognizer:tap];
    [tap.rac_gestureSignal subscribeNext:^(id x) {
        //点击事件响应的逻辑
        NSLog(@"%@",x);
    }];
}

//MARK: 2.KVO
//MARK:2.传统的KVO监听方式
- (void)KVO_method {
    [self.testLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"text"] && object == self.testLabel) {
        NSLog(@"%@", change);
    }
}
//MARK: 2-2.RAC的KVO方式
- (void)RAC_KVO {
    [RACObserve(self.testLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//MARK:3.RAC的delegate代理实现方式
//3.delegate代理
- (void)RACTextFieldDelegate {
    [[self rac_signalForSelector:@selector(textFieldDidBeginEditing:) fromProtocol:@protocol(UITextFieldDelegate)]
     subscribeNext:^(RACTuple * _Nullable x) {
         NSLog(@"%@",x);
     }];
    self.testTextField.delegate = self;
}
//MARK: 4.RAC的Notification通知实现方式
//4.Notification通知
-(void)RACNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidHideNotification object:nil]
     subscribeNext:^(NSNotification * _Nullable x) {
         NSLog(@"%@",x);
     }];
}

//MARK:5.RAC的定时器timer的实现方式
//5.定时器timer
- (void)RACTimer {
    //主线程中每两秒执行一次
    [[RACSignal interval:2.0 onScheduler:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(NSDate * _Nullable x) {
         NSLog(@"one_date = %@",x);
     }];
    
    //创建一个新线程
    [[RACSignal interval:1 onScheduler:[RACScheduler schedulerWithPriority:(RACSchedulerPriorityHigh) name:@"com.RacctiveCocoa.RACScheduler.mainThreadScheduler"]]
     subscribeNext:^(NSDate * _Nullable x) {
         NSLog(@"two_date = %@",x);
     }];
}

//MARK:6.RAC的数组与字典的使用
//6.数组与字典
- (void)RACSequence {
    //遍历数组
    NSArray *racAry = @[@"rac1", @"rac2", @"rac3"];
    [racAry.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //遍历字典
    NSDictionary *dict = @{@"name":@"dragon", @"type":@"fire", @"age":@"1000"};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        RACTuple *tuple = (RACTuple *)x;
        //RACTwoTuple *tuple = (RACTwoTuple *)x;
        NSLog(@"key === %@, value === %@", tuple[0], tuple[1]);
    }];
}
//MARK:7.RAC基本使用方法与流程
//7.RAC基本使用方法与流程
- (void)RACBase {
    //RAC 基本使用方法与流程
    //1. 创建signal 信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        //subscriber 并不是一个对象
        //3. 发送信号
        [subscriber sendNext:@"sendOneMessage"];
        
        //发送error信号
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:1001 userInfo:@{@"errorMsg": @"this is a error message"}];
        [subscriber sendError:error];
        
        //4. 销毁信号
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"signal已销毁");
        }];
    }];
    
    //2.1 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //2.2 订阅error信号
    [signal subscribeError:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}
//MARK: 8.使用weakify和 strongify解决block的循环引用
- (void)weakStrong {
    @weakify(self)
    [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         self.testLabel.text = @"label changed";
         NSLog(@"%@",x);
     }];
}
/*
 RAC中信号的其它动作：

 信号映射：map、flattenMap

 信号过滤：filter、ignore、distinctUntilChanged

 信号合并：combineLatest、reduce、merge、zipWith

 信号连接：concat、then

 信号操作时间：timeout、interval、dely

 信号跳过：skip

 信号取值：take、takeLast、takeUntil

 信号发送顺序：donext、cocompleted

 获取信号中的信号：switchToLatest

 信号错误重试：retry

*/


//MARK: tableViewDelegate && tableViewDataSource
-(void)p_addSectionDataWithClassNameArray:(NSArray *)classNameArray titleArray:(NSArray *)titleArray title:(NSString *)title {
    @autoreleasepool {
        NSMutableArray *firstArray=@[].mutableCopy;
        
        [classNameArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SGHCellModel *cellModel = [SGHCellModel new];
            cellModel.className=obj;
            cellModel.title=titleArray[idx];
            [firstArray addObject:cellModel];
        }];
        
        [self p_addSectionTitle:title dataArray:firstArray];
        
        
    }
}

-(void)p_addSectionTitle:(NSString *)sectionTitle dataArray:(NSMutableArray *)dataArray {
    [self.dataArray addObject:dataArray];
    [self.sectionTitle addObject:sectionTitle];
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitle[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSMutableArray *)self.dataArray[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YY"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YY"];
    }
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = cellMoel.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SGHCellModel *cellMoel= self.dataArray[indexPath.section][indexPath.row];
    SEL sel = NSSelectorFromString(cellMoel.className);
    if (sel) {
        [self performSelector:sel];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
