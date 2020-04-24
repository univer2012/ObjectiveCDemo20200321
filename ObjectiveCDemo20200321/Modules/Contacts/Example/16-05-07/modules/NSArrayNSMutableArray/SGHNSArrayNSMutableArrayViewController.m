//
//  SGHNSArrayNSMutableArrayViewController.m
//  UIDatePickerDemo
//
//  Created by huangaengoln on 16/2/26.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHNSArrayNSMutableArrayViewController.h"

@interface SGHNSArrayNSMutableArrayViewController ()

@end

@implementation SGHNSArrayNSMutableArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    //[self p_session2];
    [self p_session3];
    
}

//5.可变数组（NSMutableArray）
-(void)p_session5 {
    //5.1 Initializing an Array(NS_DESIGNATED_INITIALIZER)
    //除了继承NSArray基本的init，还增加了以下指定初始化函数
    //- (instancetype)initWithCapacity:(NSUInteger)numItemsNS_DESIGNATED_INITIALIZER;
    
    
    //5.2 addObject
    //尾部追加一个元素
    //- (void)addObject:(id)anObject;
    //尾部追加一个数组
    //- (void)addObjectsFromArray:(NSArray *)otherArray;
    
    
    
    //5.3 insertObject
    //在指定索引处插入一个元素，原来的元素后移
    // index取值范围=[0, count]，index=count时相当于addObject
    //- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
    //在指定索引集合处插入一个数组元素，相当于批次insertObject: atIndex:
    //- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet*)indexes;
    
    
    
    
    //5.4 exchangeObject/replaceObject
    /*
     //交换对应索引位置的元素（索引必须有效）
     - (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
     
     //替换对应索引位置的元素（索引必须有效）
     - (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
     //替换对应索引集合位置的元素，相当于批次replaceObjectAtIndex: withObject:
     - (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray*)objects;
     
     //等效于replaceObjectAtIndex，支持中括号下标格式（array[index]）赋值替换。
     // index取值范围=[0, count]，index=count时相当于addObject
     - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idxNS_AVAILABLE(10_8,6_0);
     //等效于先removeAllObjects后addObjectsFromArray
     - (void)setArray:(NSArray *)otherArray;
     */
    
    
    
    
    
    //5.5 removeObject
    /*
     - (void)removeLastObject;
     //删除对应索引位置/范围的元素（索引/范围必须有效）
     - (void)removeObjectAtIndex:(NSUInteger)index;
     - (void)removeObjectsAtIndexes:(NSIndexSet *)indexes;
     - (void)removeObjectsInRange:(NSRange)range;
     //有则删除
     - (void)removeObject:(id)anObject;
     - (void)removeObject:(id)anObject inRange:(NSRange)range;
     - (void)removeObjectsInArray:(NSArray *)otherArray;
     - (void)removeAllObjects;
     */
    
    
}

//4.衍生数组（Deriving）
-(void)p_session4 {
    NSArray *array = @[@"e0",@"e1",@"e2",@"e3",@"e4",@"e5",@"e6"];
#if 1
    //返回指定范围（起始索引、长度）的子数组
    //-  (NSArray *)subarrayWithRange:(NSRange)range;
    //以下代码获取数组前一半子数组：
    //return the first half of the whole array
    NSArray* subArray = [array subarrayWithRange:NSMakeRange(0,array.count/2)];
    NSLog(@"subArray= %@", subArray);
    
    ////在当前数组追加元素或数组，并返回新数组对象
    //- (NSArray *)arrayByAddingObject:(id)anObject;
    //- (NSArray *)arrayByAddingObjectsFromArray:(NSArray *)otherArray;
#endif
    
}


//3.查询数组（Finding）
-(void)p_session3 {
    NSArray *array = @[@"e0",@"e1",@"e2",@"e3",@"e4",@"e5",@"e6"];
    
#if 1
    //3.1 indexOfObject(IdenticalTo)
    /*
     // 在数组（或指定范围）中，测试指定的对象是否在数组中（按值查询）
     - (NSUInteger)indexOfObject:(id)anObject; // 同containsObject
     - (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range;
     // 测试指定的对象是否在数组中（按指针查询）
     - (NSUInteger)indexOfObjectIdenticalTo:(id)anObject;
     - (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
     */
    
    
    //3.2 indexOfObject(s)PassingTest
    //使用代码块传递遍历操作过滤条件：
    //查找数组中第一个符合条件的对象（代码块过滤），返回对应索引
    //- (NSUInteger)indexOfObjectPassingTest:(BOOL (^)(id obj,NSUInteger idx, BOOLBOOL *stop))predicate NS_AVAILABLE(10_6,4_0);
    
    //以下代码用于获取值等于@”e3”的元素索引：
    NSUInteger index =[array indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj = %@  idx = %lu  stop = %@",obj,idx,(stop ? @"YES":@"NO"));
        
        
        if ([(NSString *)obj isEqualToString:@"e4"]) {
            return YES;     // 中止遍历，break
        }
        return NO;      // 继续遍历，continue
    }];
    NSLog(@"index = %lu",index);
    
    
#if 0
    NSIndexSet *indexSet = [array indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"obj = %@  idx = %lu stop = %@",obj,idx,(stop ? @"YES":@"NO"));
        if ([obj isEqualToString:@"e4"]) {
            
            *stop = YES; // 中止遍历，break
            return YES;
        }
        *stop = NO; // 继续遍历，continue
        return NO;
        //return idx;
    }];
    NSLog(@"indexSet = %@",indexSet);
#endif
    
    //查找数组中所有符合条件的对象（代码块过滤），返回对应索引集合：
    //- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (^)(id obj,NSUInteger idx, BOOLBOOL *stop)) predicate NS_AVAILABLE(10_6,4_0);
    //以上indexesOfObjectPassingTest/ indexesOfObjectsPassingTest版本默认是顺序同步遍历，它们都有另外可以指定NSEnumerationOptions参数的扩展版本。
    //indexOfObjectAtIndexes:options:passingTest:和indexOfObjectsAtIndexes:options:passingTest:则是指定索引集合内查找并返回索引（集合）。
    
#elif 0
    //3.3 firstObjectCommonWithArray
    //查找与给定数组中第一个相同的对象（按值）
    //- (id)firstObjectCommonWithArray:(NSArray *)otherArray;
    //示例：
    NSArray *subArray =@[@"e1",@"e3",@"e5"];
    id fo = [array firstObjectCommonWithArray:subArray];
    NSLog(@"fo= %@", fo); // e1
    
    
    
    
#endif
    
}

//2.访问数组（Querying）
-(void)p_session2 {
    
    NSArray *array = @[@"e0",@"e1",@"e2",@"e3",@"e4",@"e5",@"e6"];
    
#if 0
    NSString* yy = @"2015";
    NSNumber* mm = @(07);
    NSValue* dd = @(26);
    NSArray* array = @[yy, mm, dd]; // 都是NSObject对象
    NSLog(@"array = %@", array);
    
#elif 0
    //2.1 数组描述
    //@property (readonly,copy)NSString *description;
    //例如以下代码可以在调试时打印数组：
    NSArray* array = [NSArray arrayWithObjects:@"e0",@"e1",@"e2",@"e3",@"e4",@"e5",@"e6",nil];
    NSLog(@"array = %@", array);
    NSLog(@"array = %@", array.description);
    
    
    //2.2 数组大小
    ////返回数组所包含的元素（NSObject对象）个数
    //@property (readonly)NSUInteger count;
    //可以基于array.count对数组进行判空：如果array.count=0，则表示数组为nil或不包含任何元素。
    
    
#elif 0
    //2.3 数组元素
    /*
     //返回数组第一个元素
     @property (nonatomic,readonly)id firstObject NS_AVAILABLE(10_6,4_0);
     // 返回数组最后一个元素
     @property (nonatomic,readonly)id lastObject;
     
     //判断数组是否包含某个元素（按值查询）
     - (BOOL)containsObject:(id)anObject;
     
     //等效于objectAtIndex，支持中括号下标格式（array[index]）访问指定索引元素。
     - (id)objectAtIndexedSubscript:(NSUInteger)idx NS_AVAILABLE(10_8,6_0);
     
     //返回数组指定索引位置的元素，索引范围[0, count-1]
     - (id)objectAtIndex:(NSUInteger)index;
     
     //返回数组指定索引集的元素组成的子数组
     - (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes;
     
     objectAtIndex:方法用于快速返回指定索引位置的元素；firstObject和lastObject属性用于快捷访问数组的首、尾元素。
     containsObject:方法用于按值搜索查询数组是否包含某个元素。
     
     */
    
    //以下代码获取第2、4、6个元素子数组
    NSMutableIndexSet* indexSet = [NSMutableIndexSet indexSet];
    [indexSet addIndex:1];
    [indexSet addIndex:3];
    [indexSet addIndex:5];
    NSArray* subArray = [array objectsAtIndexes:indexSet];
    NSLog(@"subArray= %@", subArray);
    //等效于
    NSArray* subArray1 = [NSArray arrayWithObjects:[ array objectAtIndex:1], [array objectAtIndex:3], [array objectAtIndex:5], nil];
    NSLog(@"subArray= %@",subArray1);
    
#elif 0
    //2.4遍历数组
    //（1）索引遍历
    // 倒序：for (NSInteger index=array.count-1; index>=0; index--)
    for (NSUInteger index=0; index<array.count; index++)
    {
        //NSLog(@"array[%zd] = %@", index, [array objectAtIndex:index]); // array[index]
    }
    
    //（2）枚举遍历
    // 倒序：reverseObjectEnumerator
    NSEnumerator* enumerator = [array objectEnumerator];
    id e = nil;
    while (e = [enumerator nextObject])
    {
        //NSLog(@"e = %@", e);
    }
    /*
     for (id e in enumerator) {
     NSLog(@"e = %@",e);
     }
     */
    
    
    //(3)使用代码块传递遍历操作：
    //-(void)enumerateObjectsUsingBlock:(void (^)(id obj,NSUInteger idx,BOOL *stop))block NS_AVAILABLE(10_6,4_0);
    // 示例1：枚举遍历
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog(@"obj = %@", obj);
    }];
    
    // 示例2：枚举遍历，遇到符合条件的元素即退出遍历。
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //NSLog(@"obj = %@",obj);
        if ([obj isEqualToString:@"e3"]) {
            *stop = YES; // 中止遍历， break
        } else {
            *stop = NO; // 继续遍历，continue
        }
    }];
    
    //以上版本默认是顺序同步遍历，另外一个版本可以指定NSEnumerationOptions参数：  ---???-16-002-26
    /*
     typedef NS_OPTIONS(NSUInteger, NSEnumerationOptions) {
     NSEnumerationConcurrent = (1UL <<0),// block并发
     NSEnumerationReverse = (1UL <<1),//倒序
     };
     */
    
    
    //（3）快速遍历
    for (id e in array) {
        //NSLog(@"e = %@", e);
    }
    
#endif
    
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
