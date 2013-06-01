//
//  EventWorkshop.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Event.h"

@interface EventWorkshop : Event
{
@protected
    NSString* needs;
}

// Worshop needs
@property (nonatomic) NSString* needs;

/**
 Initializes a new EventWorkshop object
 @param eID id of the event
 @param d date and time of the event
 @param t title of the event
 @param th theme of the event
 @param s speaker of the event
 @param n needs of the workshop
 @returns a newly initialized object
 */
-(EventWorkshop*)initWithDataAndSpeaker:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th speaker:(Speaker*)s needs:(NSString*)n;

/**
 Gets the workshop needs
 @returns workshop needs
 */
-(NSString*)getNeeds;

@end
