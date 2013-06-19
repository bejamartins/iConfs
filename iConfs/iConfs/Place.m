//
//  Place.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Place.h"

@implementation Place

-(Place*)initPlace: (NSString*)p name:(NSString *)n x:(int)xx y:(int)yy x:(int)xx y:(int)yy{
    x = xx;
    y = yy;
    placeID = p;
    name = n;
    return self;
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

-(NSString*)getID{
    return placeID;
}

@end
