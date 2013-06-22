//
//  Session.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Event.h"
#import "Author.h"

@interface Session : Event
{
    @protected
    Author* author;
    int paperID;
}

//Session author
@property (nonatomic) Author* author;

/**
 Initializes a new Session object
 @param eID id of the event
 @param d date and time of the event
 @param t title of the event
 @param th theme of the event
 @param s speaker of the event
 @param a author of the workshop
 @returns a newly initialized object
 */
-(Session*)initWithDataAndSpeaker:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th speaker: (Speaker*)s athor: (Author*) a paper: (int)pID;

/**
 Gets the session's author
 @returns session's author
 */
-(Author*)getAuthor;

-(int)getPaperID;

- (NSComparisonResult)compare:(Event *)otherObject;
@end



//#endif

