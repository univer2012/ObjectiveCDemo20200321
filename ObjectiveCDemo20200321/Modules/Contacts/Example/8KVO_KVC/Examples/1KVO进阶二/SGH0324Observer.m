//
//  SGH0324Observer.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/3/24.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0324Observer.h"

@implementation SGH0324Observer

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@-%@-%@",[self class],object,change);
}

@end
