//
//  SGH0503MRCPerson.m
//  ObjectiveCDemo20200321
//
//  Created by 远平 on 2020/5/3.
//  Copyright © 2020 远平. All rights reserved.
//

#import "SGH0503MRCPerson.h"

@implementation SGH0503MRCPerson

//strong
-(void)setName:(NSString *)name
{
    if (_name != name)
    {
        [_name release];
        _name = [name retain];
    }
}

//copy
-(void)setFatherName:(NSString *)fatherName
{
    if (_fatherName != fatherName)
    {
        [_fatherName release];
        _fatherName = [fatherName copy];
    }
}

//retain
-(void)setMotherName:(NSString *)motherName
{
    if (_motherName != motherName)
    {
        [_motherName release];
        _motherName = [motherName retain];
    }
}


@end
