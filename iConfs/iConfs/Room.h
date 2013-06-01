//
//  Room.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Place.h"

@interface Room : Place
{
    @protected
    NSString* name;
}

//Room name/designation
@property (nonatomic) NSString* name;

/**
 Initializes a new Room object
 @param x xx' coordinate
 @param y yy' coordinate
 @param n room name/designation
 @returns a newly initialized object
 */
-(Room*)initRoom: (int)xx y:(int)yy name:(NSString*)n;

/**
 Gets the room name
 @returns room name/designation
 */
-(NSString*)getName;

/**
 Sets the room name
 @param n room area name
 @returns 
 */
-(void)setName: (NSString*)n;

@end
