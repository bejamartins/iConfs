//
//  Organizer.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Person.h"

@interface Organizer : Person
{
 @protected
 NSString* job;
}
@property (nonatomic) NSString* job;

/**
 Initializes a new Organizer object
 @param n name of the person
 @param h the person's profession
 @param imgPath the path to the person's picture
 @param pID person's ID
 @param c organizer's job
 @returns a newly initialized object
 */
-(Organizer*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID job: (NSString*)j;

/**
 Gets the organizer's job
 @returns organizer's job
 */
-(NSString*)getJob;

/**
 Sets the organizer's job
 @param c new organizer's job
 @returns 
 */
-(void)setJob:(NSString*)j;

@end
