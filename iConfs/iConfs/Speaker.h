//
//  Speaker.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Person.h"

@interface Speaker : Person
{
    @protected
    NSString* resume;
}

//Speaker's resume
@property (nonatomic) NSString* resume;

/**
 Initializes a new Speaker object
 @param n name of the person
 @param h the person's profession
 @param imgPath the path to the person's picture
 @param pID person's ID
 @param c organizer's job
 @param r speaker's resume
 @returns a newly initialized object
 */
-(Speaker*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID resume: (NSString*)r;

/**
 Gets the speaker's resume
 @returns speaker's resume
 */
-(NSString*)getResume;

/**
 Sets the speaker's resume
 @param r new speaker's resume
 @returns 
 */
-(void)setResume:(NSString*)r;

@end
