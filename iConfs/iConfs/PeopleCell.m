//
//  PeopleCell.m
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

@synthesize index,indexSupersessions,indexSession;
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
-(int)getIndexSupersessions{
    
    return indexSupersessions;
}
-(int)getIndexSession{
    
    return indexSession;
}
@end
