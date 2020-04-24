//
//  SGH0506OCRuntime1ViewController.m
//  ObjectiveCDemo160728
//
//  Created by huangaengoln on 2017/5/6.
//  Copyright © 2017年 huangaengoln. All rights reserved.
//

/**
 这是来自文章：[Objective-C Runtime 运行时之一：类与对象](http://blog.jobbole.com/79566/)
 的例子，亲自实践之

 @param void
 @return
 */
#import "SGH0506OCRuntime1ViewController.h"
#import "SGH0506Test.h"
#import "SGH170506MyClass.h"
#import <objc/runtime.h>

@interface SGH0506OCRuntime1ViewController ()

@end

@implementation SGH0506OCRuntime1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self p_testOne];
    
    //[[SGH0506Test new] ex_registerClassPair];
    
    
    //[self p_testMyClass];
    
    //[self p_testRuntimeCreateAClass];
    
    [self p_testAlloc];
    
    //[self p_testGetClassList];
    
    
    
    
}


-(void)p_testGetClassList {
    int numClasses;
    Class *classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        classes = malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        
        NSLog(@"number of classes: %d", numClasses);
        
        for (int i = 0; i < numClasses; i++) {
            Class cls = classes[i];
            NSLog(@"class name: %s", class_getName(cls));
        }
    }
    free(classes);
}


-(void)p_testAlloc {
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
    id str1 = [theObject init];
    NSLog(@"%@", [str1 class]);
    
    id str2 = [[NSString alloc]initWithString:@"test"];
    NSLog(@"%@", [str2 class]);
    [str2 release];
}





void imp_submethod1(id self, SEL _cmd) {
    NSLog(@"run sub method 1");
}

//-(void)submethod1 {
//    
//}

-(void)p_testRuntimeCreateAClass {
    Class cls = objc_allocateClassPair(SGH170506MyClass.class, "SGH170506MySubClass", 0);
    class_addMethod(cls, @selector(submethod1), (IMP)imp_submethod1, "v@:");
    class_replaceMethod(cls, @selector(method1), (IMP)imp_submethod1, "v@:");
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log(sizeof(NSString *)), "i");
    
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = {"C", ""};
    objc_property_attribute_t backingivar = {"V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownership, backingivar};
    
    class_addProperty(cls, "property2", attrs, 3);
    objc_registerClassPair(cls);
    
    id instance = [[cls alloc]init];
    [instance performSelector:@selector(submethod1)];
    [instance performSelector:@selector(method1)];
    
}

//MARK:
-(void)p_testMyClass {
    SGH170506MyClass *myClass = [[SGH170506MyClass alloc]init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    [myClass release];
    //类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"===============================================");
    
    //父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"===============================================");
    
    //是否是元类
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"": @"not") );
    NSLog(@"===============================================");
    
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class) );
    NSLog(@"===============================================");
    
    //变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls) );
    NSLog(@"===============================================");
    
    //成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i );
    }
    free(ivars);
    //获取类中指定名称实例成员变量
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instance variable %s", ivar_getName(string) );
    }
    NSLog(@"===============================================");
    
    //属性操作
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property) );
    }
    free(properties);
    //获取指定的属性
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array) );
    }
    NSLog(@"===============================================");
    
    //方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method: %p", method_getName(classMethod) );
    }
    BOOL isResponds = class_respondsToSelector(cls, @selector(method3WithArg1:arg2:));
    NSLog(@"MyClass is %@response to selector: method3WithArg1:arg2:", (isResponds ? @"" : @"not"));
    
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp;//imp();  在Build Settings中找`Enable Strict Checking of objc_msgSend Calls`
    NSLog(@"===============================================");
    
    //协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol *protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name : %s", protocol_getName(protocol));
    }
    BOOL isConforms = class_conformsToProtocol(cls, protocol);
    NSLog(@"MyClass is %@ responsed to protocol %s",(isConforms ? @"" : @"not"), protocol_getName(protocol));
    NSLog(@"===============================================");
    
}





//在上面我们提到，所有的类自身也是一个对象，我们可以向这个对象发送消息(即调用类方法)。如：
-(void)p_testTwo {
    NSArray *array = [NSArray array];
}
/*
 这个例子中，+array消息发送给了NSArray类，而这个NSArray也是一个对象。既然是对象，那么它也是一个objc_object指针，它包含一个指向其类的一个isa指针。那么这些就有一个问题了，这个isa指针指向什么呢？为了调用+array方法，这个类的isa指针必须指向一个包含这些类方法的一个objc_class结构体。这就引出了meta-class的概念
 
 */












//MARK: one
//针对cache，我们用下面例子来说明其执行过程：
-(void)p_testOne {
    NSArray *array = [[NSArray alloc] init];
    [array release];
}
/*
 其流程是：
 
 1.[NSArray alloc]先被执行。因为NSArray没有+alloc方法，于是去父类NSObject去查找。
 2.检测NSObject是否响应+alloc方法，发现响应，于是检测NSArray类，并根据其所需的内存空间大小开始分配内存空间，然后把isa指针指向NSArray类。同时，+alloc也被加进cache列表里面。
 3.接着，执行-init方法，如果NSArray响应该方法，则直接将其加入cache；如果不响应，则去父类查找。
 4.在后期的操作中，如果再以[[NSArray alloc] init]这种方式来创建数组，则会直接从cache中取出相应的方法，直接调用。
 */

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
