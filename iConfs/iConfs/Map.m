//
//  Map.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "Map.h"

@implementation Map

-(Map*)initWithData: (NSString*)mID lat:(float)lt longi: (float)lg placeName:(NSString*)pn address: (NSString*)add{
    mapID = mID;
    latitude = lt;
    longitude = lg;
    placeName = pn;
    address = add;
    return self;
}

-(NSString*)getID{
    return mapID;
}

-(NSString*)getPlaceName{
    return placeName;
}

-(NSString*)getAddress{
    return address;
}

-(float)getLat{
    return latitude;
}

-(float)getLong{
    return longitude;
}

@end
