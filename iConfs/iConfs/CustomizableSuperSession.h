//
//  CustomizableSuperSession.h
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 24/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "SuperSession.h"

@interface CustomizableSuperSession : SuperSession{
    @protected
    NSMutableDictionary* userSessionsDic;
    NSMutableDictionary* userWorkshopsDic;
    NSMutableDictionary* userAllEventsDic;
    NSMutableArray* userSessions;
    NSMutableArray* userWorkshops;
    NSMutableArray* userAllEvents;
    NSDate* userStartDate;
    NSString* confID;
}

/**
 Initializes a new CustomizableSuperSession object
 @param sID SuperSession ID
 @param t SuperSession theme
 @returns a newly initialized object
 */
-(CustomizableSuperSession*)initWithData: (NSString*)sID theme: (NSString*)t;

/**
 Initializes a new CustomizableSuperSession object with an existing SuperSession data
 @param ss existing SuperSession
 @returns a newly initialized object
 */
-(CustomizableSuperSession*)initWithSuperSession: (SuperSession*)ss Conference: (NSString*)cID;

/**
 Subscribes to all events on the CustomizableSuperSession
 */
-(void)subscribeAllEvents;

/**
 Subscribes to all sessions on the CustomizableSuperSession
 */
-(void)subscribeAllSessions;

/**
 Subscribes to all workshops on the CustomizableSuperSession
 */
-(void)subscribeAllWorkshops;

/**
 Subscribes an other event to the CustomizableSuperSession
 @param e event to subscribe
 @returns true if the event has been successfully subscribed, false if already had been subscribed or isn't in the corresponding supersession
 */
-(BOOL)subscribeOtherEvent:(Event*) e;

/**
 Subscribes a session to the CustomizableSuperSession
 @param e session to subscribe
 @returns true if the session has been successfully subscribed, false if already had been subscribed or isn't in the corresponding supersession
 */
-(BOOL)subscribeSession:(Session*) e;

/**
 Subscribes a workshop to the CustomizableSuperSession
 @param e workshop to subscribe
 @returns true if the workshop has been successfully subscribed, false if already had been subscribed or isn't in the corresponding supersession
 */
-(BOOL)subscribeWorksop:(EventWorkshop*) e;

/**
 Unsubscribes a session from the CustomizableSuperSession
 @param sessionID session ID to unsubscribe
 @returns true if the session has been successfully unsubscribed, false if has not been subscribed
 */
-(BOOL)unsubscribeSession:(int)sessionID;

/**
 Unsubscribes a workshop from the CustomizableSuperSession
 @param workshopID workshop ID to unsubscribe
 @returns true if the event has been successfully unsubscribed, false if has not been subscribed
 */
-(BOOL)unsubscribeWorkshop:(int)workshopID;

/**
 Unsubscribes an other event from the CustomizableSuperSession
 @param eventID event ID to unsubscribe
 @returns true if the event has been successfully unsubscribed, false if has not been subscribed
 */
-(BOOL)unsubscribeOtherEvent:(int)eventID;

/**
 Gets the starting date (and time) of the user CustomizableSuperSession, i.e.: the starting date of the first event subscribed
 @returns the starting date (and time) of the CustomizableSuperSession
 */
-(NSDate*)getUserStartDate;

/**
 Gets a dictionary with all the subscribed user sessions indexed by ID
 @returns dictionary with all the subscribed user sessions indexed by ID
 */
-(NSDictionary*)getUserSessionsDicionary;


/**
 Gets a dictionary with all the subscribed user workshops indexed by ID
 @returns dictionary with all the subscribed user workshops indexed by ID
 */
-(NSDictionary*)getUserWorkshopsDicionary;

/**
 Gets a dictionary with all the subscribed user events indexed by ID
 @returns dictionary with all the subscribed user events indexed by ID
 */
-(NSDictionary*)getUserAllEventsDicionary;

/**
 Gets all the subscribed user sessions ordered by start date
 @returns subscribed user sessions ordered by start date
 */
-(NSArray*)getUserSessionsOrderedByDate;

/**
 Gets all the subscribed user workshops ordered by start date
 @returns subscribed user sessions workshops by start date
 */
-(NSArray*)getUserWorkshopsOrderedByDate;

/**
 Gets all the subscribed user events ordered by start date
 @returns subscribed user sessions eventd by start date
 */
-(NSArray*)getUserAllEventsOrderedByDate;

/**
 Returns the list of unsubscribed events
 @returns list of unsubscribed events by the user
 */
-(NSArray*)getUnsubscribedEvents;

/**
 Returns the list of unsubscribed sessions
 @returns list of unsubscribed sessions by the user
 */
-(NSArray*)getUnsubscribedSessions;

/**
 Returns the list of unsubscribed workshops
 @returns list of unsubscribed workshops by the user
 */
-(NSArray*)getUnsubscribedWorkshops;

-(NSComparisonResult)compare:(CustomizableSuperSession*)otherObject;

-(NSString*)getConfID;

@end
