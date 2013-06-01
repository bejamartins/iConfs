//
//  Place.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Place: NSObject
{
@protected
    int x;
    int y;
    NSString* logoPath;
}

//xx' coordinate
@property (nonatomic) int x;

//yy' coordinate
@property (nonatomic) int y;

//path to the place's logo image
@property (nonatomic) NSString* logoPath;


/**
 Initializes a new Place object
 @param x xx' coordinate
 @param y yy' coordinate
 @returns a newly initialized object
 */
-(Place*)initPlace: (int)xx y:(int)yy;

/**
 Gets the xx' coordinate
 @returns xx' coordinate
 */
-(int)getX;

/**
 Gets the yy' coordinate
 @returns xx' coordinate
 */
-(int)getY;

/**
 Resets the xx' coordinate
 @param xx new xx' coordinate
 @returns 
 */
-(void)resetX:(int)xx;

/**
 Resets the yy' coordinate
 @param yy new yy' coordinate
 @returns 
 */
-(void)resetY:(int)yy;

/**
 Gets the logo path
 @returns logo path
 */
-(NSString*) getLogo;

/**
 Sets a logo path
 @param new logo path
 @returns 
 */
-(void)alterLogo:(NSString*)l;

@end