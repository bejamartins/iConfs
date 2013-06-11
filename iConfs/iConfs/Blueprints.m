//
//  Blueprints.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "Blueprints.h"

@implementation Blueprints

-(Blueprints*)initWithData: (NSString*)bID title: (NSString*)t imagePath:(NSString*)ip places: (NSArray*)p{
    bluePrintsID = bID;
    title = t;
    imagePath = ip;
    places = p;
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
-(NSArray*)getPlaces{
    return places;
}

@end
