//
//  EOCFamily.m
//  ObjectiveCDemo160728
//
//  Created by 远平 on 2019/11/3.
//  Copyright © 2019 huangaengoln. All rights reserved.
//

#import "EOCFamily.h"

@implementation EOCFamily
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        _person = [EOCPerson new];
        _eocAry = [NSMutableArray new];
    }
    return self;
}
    
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    if ([key isEqualToString:@"name"]) {
//        return NO;
//    }
//    return YES;
//}
    
//- (void)setName:(NSString *)name {
//    [self willChangeValueForKey:name];
//    _name = @"name";
//    [self didChangeValueForKey:name];
//}
    
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
    NSSet *keySet = [super keyPathsForValuesAffectingValueForKey:key];
    
    if ([key isEqual:@"person"]) {
        NSSet *set = [NSSet setWithObject:@"_person.age"];
        keySet = [keySet setByAddingObjectsFromSet:set];
    }
    return keySet;
}
    

@end
