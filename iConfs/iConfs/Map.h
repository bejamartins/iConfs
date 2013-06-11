//
//  Map.h
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Map : NSObject{
    @protected
    NSString* mapID;
    float latitude;
    float longitude;
    NSString* placeName;
    NSString* address;
}

/**
 Initializes a new map object
 @param aConferences list of all conferences available
 @returns a newly initialized object
 */
-(Map*)initWithData: (NSString*)mID lat:(float)lt longi: (float)lg placeName:(NSString*)pn address: (NSString*)add;

-(NSString*)getID;

-(NSString*)getPlaceName;

-(NSString*)getAddress;

-(float)getLat;

-(float)getLong;

@end
