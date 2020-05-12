//
//  SGH0425RunloopImageViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/4/25.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

#import "SGH0425RunloopImageViewController.h"

#import <CoreFoundation/CoreFoundation.h>

//定义一个block
typedef BOOL(^RunloopBlock)(void);

static NSString *kIdentifier = @"kIdentifier";
static CGFloat kCell_Height = 135.f;

@interface SGH0425RunloopImageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *exampleTableView ;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSMutableArray *tasks;

@property(nonatomic)NSInteger maxQueueLenght;


@end

@implementation SGH0425RunloopImageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.exampleTableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        tableView;
    });
    self.tasks = [NSMutableArray array];
    self.maxQueueLenght = 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerMegthod) userInfo:nil repeats:YES];
    
    //注册cell
    [self.exampleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kIdentifier];
    //添加Runloop的观察者
    [self addRunloopObserver];
}

- (void)dealloc {
    NSLog(@"SGH0425RunloopImageViewController dealloc");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.exampleTableView.frame = self.view.bounds;
}
//不做事情
-(void)timerMegthod { }



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCell_Height;
}


//MARK: - <tableview>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 399;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //干掉contentView 上面的子控件，节约内存
    for (NSInteger i = 1; i <= 5; i++) {
        //干掉contentView 上面所有的子控件
        [[cell.contentView viewWithTag:i] removeFromSuperview];
    }
    //添加文字
    [SGH0425RunloopImageViewController addlabel:cell indexPath:indexPath];
    
    //添加图片 -- 每一次RunLoop循环 加载一个图片
    //吧这个好事操作的代码，扔到数组里面去，先不执行
//    [SGH0425RunloopImageViewController addImage1With:cell];
//    [SGH0425RunloopImageViewController addImage2With:cell];
//    [SGH0425RunloopImageViewController addImage3With:cell];
    [self addTask:^BOOL{
        [SGH0425RunloopImageViewController addImage1With:cell];
        return YES;
    }];
    [self addTask:^BOOL{
        [SGH0425RunloopImageViewController addImage2With:cell];
        return YES;
    }];
    [self addTask:^BOOL{
        [SGH0425RunloopImageViewController addImage3With:cell];
        return YES;
    }];
    
    return cell;
}

//MARK: - <关于RunLoop的方法和函数>
-(void)addTask:(RunloopBlock)unit {
    [self.tasks addObject:unit];
    //保证数组里面只有30个任务
    if (self.tasks.count > self.maxQueueLenght) {
        [self.tasks removeObjectAtIndex:0];
    }
}


//RumLoop的回调函数
//从数组里面拿代码执行
static void CallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
//    NSLog(@"来了来了！！！");
    SGH0425RunloopImageViewController *vc = (__bridge SGH0425RunloopImageViewController *)(info);
    if (vc.tasks.count == 0) {
        return;
    }
    BOOL result = NO;
    while (result == NO && vc.tasks.count) {
        //取出任务
        RunloopBlock unit = vc.tasks.firstObject;
        //执行任务
        result = unit();
        //干掉刚执行完毕的任务
        [vc.tasks removeObjectAtIndex:0];
    }
}

//这里面都是C语言的
-(void)addRunloopObserver {
    //获取当前Runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个上下文
    CFRunLoopObserverContext context = {
      0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //定义一个观察者  CallBack是一个回到函数
    static CFRunLoopObserverRef defaultObserver;
    //创建观察者
    defaultObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, NSIntegerMax - 999, &CallBack, &context);
    //添加当前Runloop的观察者
    CFRunLoopAddObserver(runloop, defaultObserver, kCFRunLoopDefaultMode);
    
    //C语言有create就需要release
    CFRelease(defaultObserver);
    
    
}


//MARK: 私有类方法
+(void)addlabel:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    UILabel *label = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 300, 25)];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
        label.tag = 4;
        label;
    });
    [cell.contentView addSubview:label];
    
    UILabel *label1 = ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 99, 300, 25)];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:0 green:100.f/255.0 blue:0 alpha:1];
        label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority. Should be distributed into different run loop passes.", indexPath.row];
        label.tag = 5;
        label;
    });
    [cell.contentView addSubview:label1];
    
}
//加载第1张图片
+(void)addImage1With:(UITableViewCell *)cell {
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(5, 20, 85, 85)];
    imageView2.tag = 1;
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"sea" ofType:@"png"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:path1];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = image2;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView2];
    } completion:nil];
}
//加载第2张图片
+(void)addImage2With:(UITableViewCell *)cell {
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(105, 20, 85, 85)];
    imageView2.tag = 2;
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"sea" ofType:@"png"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:path1];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = image2;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView2];
    } completion:nil];
}

//加载第三张图片
+(void)addImage3With:(UITableViewCell *)cell {
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(200, 20, 85, 85)];
    imageView2.tag = 3;
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"sea" ofType:@"png"];
    UIImage *image2 = [UIImage imageWithContentsOfFile:path1];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = image2;
    [UIView transitionWithView:cell.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
        [cell.contentView addSubview:imageView2];
    } completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
