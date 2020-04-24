//
//  SH0227SeniorCampViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/2/27.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SH0227SeniorCampViewController.h"

#import "SH1902Person.h"

#import "SHRuntime4Person.h"

#import <objc/runtime.h>

#import "SHProxy.h"

#import "SHLeaks0301Object.h"

@interface SH0227SeniorCampViewController ()<UITableViewDataSource,UITableViewDelegate>

/** tableView  */
@property (nonatomic, strong)UITableView *tableView;

/** Description  */
@property (nonatomic, strong)NSArray *tableViewDataArray;

/** p1  */
@property (nonatomic, strong)SHRuntime4Person *p1;
/** p2  */
@property (nonatomic, strong)SHRuntime4Person *p2;


@property (nonatomic, copy)dispatch_block_t block;
@property (nonatomic, copy)NSString *str;

/** timer  */
@property (nonatomic, strong)NSTimer *timer;
/** taret  */
//@property (nonatomic, strong)id target;
@property (nonatomic, strong)SHProxy *lgProxy;

@end

@implementation SH0227SeniorCampViewController

- (void)dealloc {
    NSLog(@"LG dealloc");
//    [self.timer invalidate];
//    self.timer = nil;
}

//#pragma mark 第一种
//- (void)didMoveToParentViewController:(UIViewController *)parent {
//    if (parent == nil) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//}
//#pragma mark 第二种
//void fireImp(id self, SEL _cmd) {
//    NSLog(@"fireIMP --- fire... ...");
//}
#pragma mark 第三种
//NSProxy 是抽象基类，跟NSObject一样
//主要做些什么事情呢？它负责将我们的消息转发到真正的类的一个代理类。相当于一个中间者。

//CG C语言的方法
- (void)scence01 {//案发现场01
    CGPathRef shadowPath = CGPathCreateWithRect(CGRectMake(0, 0, 20, 20), NULL);
}
//文件
- (void)scence02 {
    FILE *f;
    f = fopen("info.plist", "r");
}

- (void)scence03:(void(^)(void))callback {
    callback();
}
- (NSArray *)scence04 {
    NSString *str = nil;
    return @[@"scence01",str, @"scence02"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[SH1902Person new] sendMessage:@"hello"];
    
#if 1 //7 iOS开发之内存泄漏
//    [self scence01];
//    [self scence02];
//    [self scence03:nil];
//    [self scence04];
    
    
    SHLeaks0301Object *a = [SHLeaks0301Object new];
    SHLeaks0301Object *b = [SHLeaks0301Object new];
    a.objc = b;
    b.objc = a;
    
#endif
    
    
    
#if 0//6 iOS开发之NSTimer
    //第2种
//    self.target = [NSObject new];
//    //通过消息转发
//    class_addMethod([_target class], @selector(fire), (IMP)fireImp, "v@:");
//    //第3种
//    _lgProxy = [SHProxy alloc];
//    _lgProxy.target = self;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:_lgProxy selector:@selector(fire) userInfo:nil repeats:YES];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(fire) userInfo:nil repeats:YES];
    //上面的代码相当于：
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(fire) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
#endif
    
#if 0//5iOS开发之循环引用
    __weak typeof(self) weakSelf = self;
    self.str = @"hello";
    self.block = ^{
        __strong typeof(self) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"----- %@",strongSelf.str);
        });
    };
    self.block();
#endif
    
#if 0//4Runtime自定义KVO
    _p1 = [SHRuntime4Person new];
    _p2 = [SHRuntime4Person new];
    
    _p2.name = @"Kody";
    
    NSLog(@"监听之前 ----- p1:%p, p2:%p",[_p1 methodForSelector:@selector(setName:)],
          [_p2 methodForSelector:@selector(setName:)]);
    
//    [_p1 addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    [_p1 lg_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
    
    _p1.name = @"Tom";
    
    NSLog(@"监听之后 ----- p1:%p, p2:%p",[_p1 methodForSelector:@selector(setName:)],
          [_p2 methodForSelector:@selector(setName:)]);
#endif
    
#if 0 //2Runtime方法交换
    self.tableViewDataArray = @[@"Hank",
                                @"Cooci",
                                @"Lina",
                                @"小雁子",
                                @"LGKODY"];
    
//    self.tableViewDataArray = @[];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cutsom"];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView reloadData];
#endif
    
}

- (void)fire {
    NSLog(@"fire......");
}



#if 0//4Runtime自定义KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change === %@", change);
}
#endif

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.rowHeight = UITableViewAutomaticDimension;
            tableView.estimatedRowHeight = 55;
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            tableView.backgroundColor = UIColor.yellowColor;
            tableView;
        });
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableViewDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cutsom"];
    cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
