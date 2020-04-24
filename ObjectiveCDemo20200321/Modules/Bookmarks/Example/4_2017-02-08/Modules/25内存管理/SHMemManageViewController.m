//
//  SHMemManageViewController.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/14.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHMemManageViewController.h"

@interface SHMemManageViewController ()
@property(nonatomic,weak)id obj;

@end

@implementation SHMemManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    NSArray *array=[NSArray array];
    //    [array release];
    
#if 0
    id __weak obj=[[NSObject alloc]init];
    
#elif 0
    //ARC
    id __weak obj1=nil;
    {
        id __strong obj0=[[NSObject alloc]init];
        obj1=obj0;
        NSLog(@"A:%@",obj1);
    }
    NSLog(@"B:%@",obj1);
    /*
     A:<NSObject: 0x7fb788502a00>
     B:(null)
     */
    
#elif 0
    //ARC
    id __unsafe_unretained obj=[[NSObject alloc]init];
#elif 0
    //ARC
    id __unsafe_unretained obj1=nil;
    {
        id __strong obj0=[[NSObject alloc]init];
        obj1=obj0;
        NSLog(@"A:%@",obj1);
    }
    NSLog(@"B:%@",obj1);
    /*
     A:<NSObject: 0x7fa24b419b90>
     B:<NSObject: 0x7fa24b419b90>
     */
#elif 0
    //ARC无效
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
    id obj=[[NSObject alloc]init];
    [obj autorelease];
    [pool drain];
    
#elif 0
    //ARC有效
    @autoreleasepool {
        id __autoreleasing obj=[[NSObject alloc]init];
    }
#elif 0
    //ARC有效
    id obj=[[NSObject alloc]init];
    void *p=(__bridge void *)obj;
    id o=(__bridge id)p;
    
    
    //__bridge_retained
#elif 0
    id obj=[[NSObject alloc]init];
    void *p=(__bridge_retained void *)obj;
#elif 0
    void *p=0;
    {
        id obj=[[NSObject alloc]init];
        p=(__bridge_retained void *)obj;
    }
    NSLog(@"class=%@",[(__bridge id)p class]);
    //class=NSObject
    
#elif 0
    //ARC有效
    id obj=(__bridge_transfer id)p;
#elif 0
    //ARC有效
    void *p=(__bridge_retained void *)[[NSObject alloc]init];
    NSLog(@"class=%@",[(__bridge id)p class]);
    (void)(__bridge_transfer id)p;
    //class=NSObject
    
#elif 0
    CFMutableArrayRef cfObject=NULL;
    {
        id obj=[[NSMutableArray alloc]init];
        //CFBridgingRetain
        //        cfObject=CFBridgingRetain(obj);
        /*
         (
         )
         retain count = 2
         retain count after the scope = 1
         */
        
        //__bridge_retained
        cfObject=(__bridge_retained CFMutableArrayRef)obj;
        /*
         (
         )
         retain count = 2
         retain count after the scope = 1
         */
        
        //__bridge
        //        cfObject=(__bridge CFMutableArrayRef)obj;
        /*
         retain count after the scope = 1
         array(35976,0x10849e000) malloc: *** error for object 0x7f92f1d0f980: pointer being freed was not allocated
         *** set a breakpoint in malloc_error_break to debug
         */
        
        //CFMutableArrayRef cfObject=(__bridge_retained CFMutableArrayRef)obj;
        CFShow(cfObject);
        printf("retain count = %ld\n",CFGetRetainCount(cfObject));
    }
    printf("retain count after the scope = %ld\n",CFGetRetainCount(cfObject));
    CFRelease(cfObject);
    
#elif 1
    id obj;
    
#endif
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
