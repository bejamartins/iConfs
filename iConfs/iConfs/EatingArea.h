//
//  EatingArea.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Place.h"

@interface EatingArea: Place
{
    @protected
    NSString* name;
}

//Eating area name
@property (nonatomic) NSString* name;

/**
 Initializes a new EatingArea object
 @param x xx' coordinate
 @param y yy' coordinate
 @param n eating area name
 @returns a newly initialized object
 */
-(EatingArea*)initEA: (int)xx y:(int)yy name:(NSString*)n;

/**
 Gets the eating area name
 @returns eating area name
 */
-(NSString*)getName;

/**
 Sets the eating area name
 @param n new eating area name
 @returns 
 */
-(void)setName: (NSString*)n;

@end
