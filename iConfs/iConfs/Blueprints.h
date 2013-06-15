//
//  Blueprints.h
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Blueprints : NSObject{
    @protected
    NSString* title;
    NSString* imagePath;
    NSString* bluePrintsID;
    NSArray* otherPlaces;
    NSArray* wcs;
    NSArray* rooms;
    NSArray* eatingAreas;
    
}

/**
 Initializes a new iConfs object
 @param aConferences list of all conferences available
 @returns a newly initialized object
 */
-(Blueprints*)initWithData: (NSString*)bID title: (NSString*)t imagePath:(NSString*)ip otherPlaces: (NSArray*)p eatingAreas: (NSArray*) eA WCs: (NSArray*) w rooms: (NSArray*) r;

-(NSString*)getTitle;
-(NSString*)getImagePath;
-(NSString*)getID;
-(NSArray*)getOtherPlaces;
-(NSArray*)getEatingAreas;
-(NSArray*)getRooms;
-(NSArray*)getWCs;

@end
