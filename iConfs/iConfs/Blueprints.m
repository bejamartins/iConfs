//
//  Blueprints.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "Blueprints.h"

@implementation Blueprints

-(Blueprints*)initWithData: initWithData: (NSString*)bID title: (NSString*)t imagePath:(NSString*)ip otherPlaces: (NSArray*)p eatingAreas: (NSArray*) eA WCs: (NSArray*) w rooms: (NSArray*) r{
    bluePrintsID = bID;
    title = t;
    imagePath = ip;
    otherPlaces = p;
    rooms = r;
    wcs = w;
    eatingAreas = eA;
    return self;
}

-(NSString*)getTitle{
    return title;
}
-(NSString*)getImagePath{
    return imagePath;
}
-(NSString*)getID{
    return bluePrintsID;
}
-(NSArray*)getOtherPlaces{
    return otherPlaces;
}

-(NSArray*)getEatingAreas{
    return eatingAreas;
}
-(NSArray*)getRooms{
    return rooms;
}
-(NSArray*)getWCs{
    return wcs;
}

@end
