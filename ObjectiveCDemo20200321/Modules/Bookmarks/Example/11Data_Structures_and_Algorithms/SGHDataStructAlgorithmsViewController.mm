//
//  SGHDataStructAlgorithmsViewController.m
//  ObjectiveCDemo20200321
//
//  Created by Mac on 2020/4/29.
//  Copyright © 2020 远平. All rights reserved.
//
/*
 来自：《数据结构(C++版)(第2版)》王红梅/胡明/王涛 编著--源代码
 */


#import "SGHDataStructAlgorithmsViewController.h"

#import "SGHDataStructAlgorithmsViewController+MRC.h"

#import "SGHLinkList.hpp"

@interface SGHDataStructAlgorithmsViewController ()

@end

@implementation SGHDataStructAlgorithmsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = SHBaseTableTypeMethod;
    
    //MARK: section 1
    NSArray *tempTitleArray = @[
        @"1.链表",
    ];
    NSArray *tempClassNameArray = @[
        @"chap2demo1",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray titleArray:tempTitleArray title:@"第2章"];
    
    //MARK: section 2
    NSArray *tempTitleArray2 = @[
        @"1.字符串反转-OC版",
        @"1_2.字符串反转-C语言版",
        @"2.链表反转",
        @"3.有序数组合并",
        @"4.HASH算法",
        @"5.查找两个子视图的共同父视图",
        @"6. 测试调用c++代码",
    ];
    NSArray *tempClassNameArray2 = @[
        @"charReverse",
        @"charReverse_C",
        @"listReverse",
        @"orderListMerge",
        @"hashTest",
        @"sec2demo5",
        @"sec2demo6",
    ];
    [self addSectionDataWithClassNameArray:tempClassNameArray2 titleArray:tempTitleArray2 title:@"算法"];
    
    [self.tableView reloadData];
}


//MARK: 6. 测试调用c++代码
- (void)sec2demo6 {
    const char *pathChar = "a";
    MyCppClass::ShowMsg(pathChar);
    float * array = GetDotClass::GetDot();
}


//MARK: 5.查找两个子视图的共同父视图
- (void)sec2demo5 {
    /* 结构如下
                                 v4
                                /
    self.view -- v1 -- v2 -- v3
                                \
                                 v5 -- v6 -- v7
    */
    UIView *v1 = [self addViewWith:self.view tag:1];
    UIView *v2 = [self addViewWith:v1 tag:2];
    UIView *v3 = [self addViewWith:v2 tag:3];
    
    UIView *v4 = [self addViewWith:v3 tag:4];
    
    UIView *v5 = [self addViewWith:v3 tag:5];
    UIView *v6 = [self addViewWith:v5 tag:6];
    UIView *v7 = [self addViewWith:v6 tag:7];
    
    [self findCommonSuperViews:v4 view2:v7];
}

- (UIView *)addViewWith:(UIView *)superV tag:(NSInteger)tag {
    UIView *view = [UIView new];
    view.tag = tag;
    [superV addSubview:view];
    return view;
}

- (void)findCommonSuperViews:(UIView *)view1 view2:(UIView *)view2 {
    
    NSArray * superViews1 = [self findSuperViews:view1];
    
    NSArray * superViews2 = [self findSuperViews:view2];
    
    NSMutableArray * publicArray = [NSMutableArray array];
    
    int i = 0;
    //只需要遍历1遍，
    //superViews1.count = 14,
    //superViews2.count = 16,
    while (i < MIN(superViews1.count, superViews2.count)) {
        //superViews1、superViews2是从叶子结点到根结点的 路径数组
        
        UIView *super1 = superViews1[superViews1.count - i - 1];//从尾部往头部取值
        
        UIView *super2 = superViews2[superViews2.count - i - 1];//从尾部往头部取值
        
        if (super1 == super2) {
            
            [publicArray addObject:super1];
            
            i++;
            
        }else{
            
            break;
        }
    }
    
    //NSLog(@"publicArray:%@", publicArray);
    NSLog(@"publicView: %@", publicArray.lastObject);
}

- (NSArray <UIView *>*)findSuperViews:(UIView *)view {
    UIView * temp = view.superview;
    
    NSMutableArray * result = [NSMutableArray array];
    
    while (temp) {
        
        [result addObject:temp];
        
        temp = temp.superview;
    }
    
    return result;
}



//MARK: 4.HASH算法
/*
 - 哈希表
   例：给定值是字母a，对应ASCII码值是97，数组索引下标为97。 这里的ASCII码，就算是一种哈希函数，存储和查找都通过该函数，有效地提高查找效率。
 
 - 在一个字符串中找到第一个只出现一次的字符。如输入"abaccdeff"，输出'b'
 
 - 字符(char)是一个长度为8的数据类型，因此总共有256种可能。 每个字母根据其ASCII码值作为数组下标对应数组种的一个数字。 数组中存储的是每个字符出现的次数。
 */
- (void)hashTest {
    /*
    void *memcpy(void *str1, const void *str2, size_t n)

    str1   -- 指向用于存储复制内容的目标数组，类型强制转换为 void* 指针。
    str2   -- 指向要复制的数据源，类型强制转换为 void* 指针。
    n      -- 要被复制的字节数。

    返回值：
    该函数返回一个指向目标存储区 str1 的指针。
    实例：
      const char src[50] = "http://www.runoob.com";
      char dest[50];
    
      memcpy(dest, src, strlen(src)+1);
      printf("dest = %s\n", dest);
    */
    
    
    NSString * testString = @"hhaabccdeef";
    
    char testCh[100];
    
    memcpy(testCh, [testString cStringUsingEncoding:NSUTF8StringEncoding], [testString length]);
    
    int list[256];
    
    for (int i = 0; i < 256; i++) {
        
        list[i] = 0;
    }
    
    char *p = testCh;       //p --> 数组的首地址
    
    char result = '\0';
    
    while (*p != result) {  //值不是结尾的 \0
        
        list[*(p++)]++;     //*p --> 取p地址上的值。
    }
    
    p = testCh;             //重新赋值p为 testCh 的首地址
    
    while (*p != result) {
        
        if (list[*p] == 1) { //如果*p --> 取值出来的字符串，出现的次数为1，

            result = *p;
            
            break;
        }
        
        p++;
    }
    
    printf("result:%c",result);
}


//MARK: 3.有序数组合并
/*
 将有序数组 {1,4,6,7,9} 和 {2,3,5,6,8,9,10,11,12} 合并为
 {1,2,3,4,5,6,6,7,8,9,9,10,11,12}
 */
- (void)orderListMerge {
    
    int a[] = {1,4,6,7,9};
    int b[] = {2,3,5,6,8,9,10,11,12};
    
    int aLen = sizeof(a) / sizeof(a[0]);    //a数组的长度：5
    int bLen = sizeof(b) / sizeof(b[0]);    //b数组的长度：9
    
    //打印数组 a、b
    [self printList:a length:aLen];
    [self printList:b length:bLen];
    
    int result[aLen + bLen];
        
    int p = 0,q = 0,i = 0;//p和q分别为a和b的下标，i为合并结果数组的下标
    
    //任一数组没有达到s边界则进行遍历
    while (p < aLen && q < bLen) {
        
        //如果a数组对应位置的值小于b数组对应位置的值,则存储a数组的值，并移动a数组的下标与合并结果数组的下标
        if (a[p] < b[q]) {
            result[i++] = a[p++];
        }
        //否则存储b数组的值，并移动b数组的下标与合并结果数组的下标
        else {
            result[i++] = b[q++];
        }
    }
    
    //如果a数组有剩余，将a数组剩余部分拼接到合并结果数组的后面
    while (++p < aLen) {
        result[i++] = a[p];
    }
    
    //如果b数组有剩余，将b数组剩余部分拼接到合并结果数组的后面
    while (q < bLen) {
        result[i++] = b[q++];
    }
    
    [self printList:result length:aLen + bLen]; //打印
}

- (void)printList:(int [])list length:(int)length {
    for (int i = 0; i < length; i++) {
        printf("%d ",list[i]);
    }
    printf("\n");
}



//MARK: 1_2.字符串反转-C语言版
- (void)charReverse_C {
    NSString * string = @"hello,world";
    //C
    char ch[100];
    //char ch[string.length];
     
     memcpy(ch, [string cStringUsingEncoding:NSUTF8StringEncoding], [string length]);

     //设置两个指针，一个指向字符串开头，一个指向字符串末尾
     char * begin = ch;
     
     char * end = ch + strlen(ch) - 1;
    
     //遍历字符数组，逐步交换两个指针所指向的内容，同时移动指针到对应的下个位置，直至begin>=end
     while (begin < end) {
         
         char temp = *begin;
         
         *(begin++) = *end;
         
         *(end--) = temp;
     }
     
     NSLog(@"reverseChar[]:%s",ch);
}

//MARK: 1.字符串反转-OC版
- (void)charReverse {
    NSString * string = @"hello,world";
    
    NSLog(@"%@",string);
    
    NSMutableString * reverString = [NSMutableString stringWithString:string];
    
    for (NSInteger i = 0; i < (string.length + 1)/2; i++) {
        
        [reverString replaceCharactersInRange:NSMakeRange(i, 1) withString:[string substringWithRange:NSMakeRange(string.length - i - 1, 1)]];
        
        [reverString replaceCharactersInRange:NSMakeRange(string.length - i - 1, 1) withString:[string substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSLog(@"reverString:%@",reverString);
}


//MARK: 第2章
//MARK: 1.链表
- (void)chap2demo1 {
    
}


@end
