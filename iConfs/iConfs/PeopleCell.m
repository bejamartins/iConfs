//
//  PeopleCell.m
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

@synthesize index;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(int)getIndex{

    return index;
}

@end
