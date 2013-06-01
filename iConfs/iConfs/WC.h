//
//  WC.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Place.h"

@interface WC : Place

/**
 Initializes a new WC object
 @param x xx' coordinate
 @param y yy' coordinate
 @returns a newly initialized object
 */
-(WC*)initPlace: (int)xx y:(int)yy;

@end
