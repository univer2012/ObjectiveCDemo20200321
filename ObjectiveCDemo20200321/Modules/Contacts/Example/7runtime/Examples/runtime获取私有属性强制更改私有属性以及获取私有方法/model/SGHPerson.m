//
//  SGHPerson.m
//  ObjectiveCDemo
//
//  Created by huangaengoln on 16/3/22.
//  Copyright © 2016年 huangaengoln. All rights reserved.
//

#import "SGHPerson.h"

@interface SGHPerson ()
@property(nonatomic,strong)NSString *address;

@end

@implementation SGHPerson

- (instancetype)init
{
    self = [super init];
    if (self) {
        _address=@"三里屯SOHO";
        self.name=@"AirZilong";
    }
    return self;
}
-(NSString *)description {
    return [NSString stringWithFormat:@"address: %@, name: %@",self.address,self.name];
}
-(void)sayHello {
    NSLog(@"hello, I'm at %@",self.address);
}
-(void)interface {
    NSLog(@"I'm %@",self.name);
}

@end
