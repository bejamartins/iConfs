//
//  MapPlace.m
//  testConection
//
//  Created by Ian on 6/16/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "MapPlace.h"

@implementation MapPlace

@synthesize coordinate, title, subtitle;

-(MapPlace*)initWithData:(CLLocationCoordinate2D)coords :(NSString *)name :(NSString *)address{
    
    coordinate=coords;
    title=name;
    subtitle=address;
    return self;
    
}

-(CLLocationCoordinate2D)getCoord{
    return coordinate;
}

-(NSString*)getTitle{
    return title;
}

-(NSString*)getSubtitle{
    return subtitle;
}

@end
