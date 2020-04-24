//
//  SHCoreDataDemoVC.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/15.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "SHCoreDataDemoVC.h"

#import <CoreData/CoreData.h>

@interface SHCoreDataDemoVC ()

@end

@implementation SHCoreDataDemoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //=========1、搭建上下文环境
    //从应用程序包中加载模型文件
    //@[[[NSBundle mainBundle]pathForResource:@"Model" ofType:@"xcdatamodeld"]]
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles: nil];
    //传入模型对象，初始化NSPersistentStoreCoordinator
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
    //构建SQLite数据库文件的路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"person.data"]];
    //添加持久化存储库，这里使用SQLite作为存储库
    NSError *error = nil;
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (store == nil) {// 直接抛出异常
        [NSException raise:@"添加数据库错误" format:@"%@",[error localizedDescription]];
    }
    //初始化上下文，设置 persistentStoreCoordinator 属性
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    context.persistentStoreCoordinator = psc;
    //用完之后，记得要 [context release];
    
    
    // =========2、添加数据到数据库
    //传入上下文，创建一个Perosn实体对象
    NSManagedObject *person = [NSEntityDescription insertNewObjectForEntityForName:@"CoreDataPerson" inManagedObjectContext:context];
    //设置Perosn的简单属性
    [person setValue:@"MJ" forKey:@"name"];
    [person setValue:[NSNumber numberWithInt:27] forKey:@"age"];
    //传入上下文，创建一个Card实体对象
    NSManagedObject *card = [NSEntityDescription insertNewObjectForEntityForName:@"CoreDataCard" inManagedObjectContext:context];
    [card setValue:@"4414241933432" forKey:@"no"];
    //设置Person和Card之间的关联关系
    [person setValue:card forKey:@"card"];
    //利用上下文对象，将数据同步到持久化存储库
    NSError *error1 = nil;
    BOOL success = [context save:&error1];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
    }
    //如果是想做更新操作：只要在更改了实体对象的属性后调用[context save:&error],就能将更改的数据同步到数据库
    
    
    
    // =============== 3、从数据库汇总查询数据
    //初始化一个查询请求
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    //设置要查询的实体
    request.entity = [NSEntityDescription entityForName:@"CoreDataPerson" inManagedObjectContext:context];
    //设置排序 （按照age降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含该字符串"Itcast-1"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*Itcast-1*)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@",@"*Itcast-1*"];
    request.predicate = predicate;
    //执行请求
    NSError *error2 = nil;
    NSArray *objs = [context executeFetchRequest:request error:&error2];
    if (error2) {
        [NSException raise:@"查询错误" format:@"%@",[error2 localizedDescription]];
    }
    //遍历数据
    for (NSManagedObject *obj in objs) {
        NSLog(@"name=%@",[obj valueForKey:@"name"]);
    }
    
    //注：Core Data不会根据实体中的关联关系立即获取相应的关联对象，比如通过Core Data取出Person实体时，并不会立即查询相关联的Card实体；当应用真的需要使用Card时，才会再次查询数据库，加载Card实体的信息。这个就是Core Data的延迟加载机制
    
    
    
    
    
    // =============4、删除数据库中的数据
    //传入需要删除的实体对象
    if (objs.count > 0) {
        [context deleteObject:objs[0]];
        //将结果同步到数据库
        NSError *error3 = nil;
        [context save:&error3];
        if (error3) {
            [NSException raise:@"删除错误" format:@"%@",[error3 localizedDescription]];
        }
    }
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
