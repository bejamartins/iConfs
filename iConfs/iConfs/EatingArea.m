//
//  EatingArea.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "EatingArea.h"

@implementation EatingArea

-(EatingArea*)initEA: (int)xx y:(int)yy name:(NSString*)n{
    x = xx;
    y = yy;
    name = n;
    return self;
}

-(NSString*)getName{
    return name;
}

-(void)setName: (NSString*)n{
    name = n;
}

-(int)getX{
    return x;
}

-(int)getY{
    return y;
}

-(void)resetX:(int)xx{
    x = xx;
}

-(void)resetY:(int)yy{
    y = yy;
}

-(NSString*) getLogo{
    return logoPath;
}

-(void)alterLogo:(NSString*)l{
    logoPath = l;
}

@end
