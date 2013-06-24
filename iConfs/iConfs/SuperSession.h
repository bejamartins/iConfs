//
//  SuperSession.h
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 22/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Session.h"
#import "EventWorkshop.h"

@interface SuperSession : NSObject{
    @protected
    NSString* ssID;
    NSMutableArray* sessions;
    NSMutableArray* workshops;
    NSMutableArray* allEvents;
    NSMutableDictionary* sessionsDic;
    NSMutableDictionary* workshopsDic;
    NSMutableDictionary* allEventsDic;
    NSDate* startDate;
    NSDate* endDate;
    NSString* theme;
}

/**
 Initializes a new SuperSession object
 @param sID SuperSession ID
 @param t SuperSession theme
 @returns a newly initialized object
 */
-(SuperSession*)initWithData: (NSString*)sID theme: (NSString*)t;

/**
 Adds a session to the SuperSession
 @param s session to add
 @returns true if the sessions has been successfully added, false if already had been added
 */
-(BOOL)addSession: (Session*)s;

/**
 Adds a workshop to the SuperSession
 @param w workshop to add
 @returns true if the workshop has been successfully added, false if already had been added
 */
-(BOOL)addWorkshop: (EventWorkshop*)w;

/**
 Adds an other event to the SuperSession
 @param e event to add
 @returns true if the workshop has been successfully added, false if already had been added
 */
-(BOOL)addOtherEvent: (Event*)e;

/**
 Gets all the sessions ordered by start date
 @returns sessions ordered by start date
 */
-(NSArray*)getSessionsOrderedByDate;

/**
 Gets all the workshops ordered by start date
 @returns workshops ordered by start date
 */
-(NSArray*)getWorkshopsOrderedByDate;

/**
 Gets all the events ordered by start date
 @returns events ordered by start date
 */
-(NSArray*)getAllEventsOrderedByDate;

/**
 Removes a session from the SuperSession
 @param sessionID session ID to remove
 @returns true if the session has been successfully removed, false if has not been added
 */
-(BOOL)removeSession:(int)sessionID;

/**
 Removes a workshop from the SuperSession
 @param workshopID workshop ID to remove
 @returns true if the workshop has been successfully removed, false if has not been added
 */
-(BOOL)removeWorkshop:(int)workshopID;

/**
 Removes an other event from the SuperSession
 @param eventID event ID to remove
 @returns true if the event has been successfully removed, false if has not been added
 */
-(BOOL)removeOtherEvent:(int)eventID;

/**
 Gets the starting date (and time) of the SuperSession, i.e.: the starting date of the first event
 @returns the starting date (and time) of the SuperSession
 */
-(NSDate*)getStartDate;

/**
 Gets a dictionary with all the sessions indexed by ID
 @returns dictionary with all the sessions indexed by ID
 */
-(NSDictionary*)getSessionsDicionary;

/**
 Gets a dictionary with all the workshops indexed by ID
 @returns dictionary with all the workshops indexed by ID
 */
-(NSDictionary*)getWorkshopsDicionary;

/**
 Gets a dictionary with all the events indexed by ID
 @returns dictionary with all the events indexed by ID
 */
-(NSDictionary*)getAllEventsDicionary;

-(NSString*)getID;

-(NSString*)getTheme;

-(NSComparisonResult)compare:(SuperSession*)otherObject;

@end
