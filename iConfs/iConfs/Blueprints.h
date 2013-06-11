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
    NSArray* places;
    
}

/**
 Initializes a new iConfs object
 @param aConferences list of all conferences available
 @returns a newly initialized object
 */
-(Blueprints*)initWithData: (NSString*)bID title: (NSString*)t imagePath:(NSString*)ip places: (NSArray*)p;

-(NSString*)getTitle;
-(NSString*)getImagePath;
-(NSString*)getID;
-(NSArray*)getPlaces;

@end
