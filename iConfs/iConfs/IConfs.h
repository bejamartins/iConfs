//
//  IConfs.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"
#import "Conference.h"
#import "AppDataObject.h"
#import "Notification.h"
#import "Event.h"
#import "EventWorkshop.h"
#import "Session.h"
#import "Map.h"
#import "Blueprints.h"
#import "Place.h"
#import "Room.h"
#import "EatingArea.h"
#import "WC.h"
#import "SuperSession.h"
#import "CustomizableSuperSession.h"

@interface IConfs : AppDataObject
{
    @protected
    NSMutableArray* conferences;
    NSMutableArray* allConferences;
    NSMutableArray* agenda;
    NSMutableDictionary* conferencesDic;
    NSMutableDictionary* allConferencesDic;
    NSMutableArray* addedConfsIDs;
    NSMutableDictionary* agendaDic;
    NSMutableDictionary* agendaDicByConf;
    NSDate* agendaStartDate;
    NSString* strDate;
    NSDate *date;
    NSArray *paths;
    NSString *documentsDirectory;
    //2) Create the full file path by appending the desired file name
    NSString *agendaFile;
    NSString *agendaDicFile;
    NSString *agendaDicByConfFile;
}

//Subscribed conferences
@property (nonatomic) NSMutableArray* conferences;

//All conferences
@property (nonatomic) NSMutableArray* allConferences;

//User agenda
@property (nonatomic) NSMutableArray* agenda;

/**
 Initializes a new iConfs object
 @param aConferences list of all conferences available
 @returns a newly initialized object
 */
-(IConfs*)initiConfs: (NSArray*)aConferences;


/**
 Adds a new event to the agenda
 @param event event to add
 @returns true, if event is added, false if it has already been added
 */
//-(BOOL)addEventToAgenda:(Event*)event;

/**
 Removes the event from the agenda
 @param eventID event ID to remove
 @returns true, if event is deleted, false if is not in the agenda
 */
//-(BOOL)removeEventFromAgenda:(int)eventID;

/**
 Returns the agenda array of events
 @returns array of agenda events
 */
//-(NSArray*)getAgenda;



/**
 Subscribes a SuperSession to the agenda
 @param ss SuperSession to subscribe
 @param cID ID of conference of origin
 @returns true if the SuperSession has been successfully subscribed, false if already had been subscribed
 */
-(BOOL)subscribeSuperSessionInAgenda: (SuperSession*)ss Conference: (NSString*)cID;

-(BOOL)subscribeSuperSessionInAgendaByID: (NSString*)ssID Conference: (NSString*)cID;

/**
 Gets all the SuperSessions subscribed ordered by start date
 @returns SuperSessions subscribed ordered by start date
 */
-(NSArray*)getAgendaOrderedByDate;

/**
 Gets a dictionary with all the subscribed SuperSessions indexed by ID
 @returns dictionary with all the subscribed SuperSessions indexed by ID
 */
-(NSDictionary*)getAgendaDicionary;

/**
 Unsubscribes a SuperSession in the agenda
 @param superSeessionID SuperSession ID to unsubscribe
 @returns true if the SuperSession has been successfully unsubscribed, false if has not been subscribed
 */
-(BOOL)unsubscribeSuperSessionInAgenda:(NSString*)superSessionID;

/**
 Gets the starting date (and time) of the user agenda, i.e.: the starting date of the first SuperSession subscribed
 @returns the starting date (and time) of the agenda
 */
-(NSDate*)getAgendaStartDate;

/**
 Returns the list of all available SuperSessions to subscribe
 @returns list of available SuperSessions for the user to subscribe
 */
-(NSArray*)getAvailableSuperSessions;

/**
 Returns the list of unsubscribed SuperSessions
 @returns list of unsubscribed SuperSessions by the user
 */
-(NSArray*)getUnsubscribedSuperSessions;

/**
 Returns the list of subscribed SuperSessions (CustomizableSuperSession) of a given Conference, ordered by subscribed start date
 @param cID conference ID
 @returns list of subscribed SuperSessions by the user of a given Conference, ordered by subscribed start date
 */
-(NSArray*)getAgendaByConferenceOrderedByDate: (NSString*) cID;

/**
 Returns the list of unsubscribed SuperSessions of a given Conference, ordered by subscribed start date
 @param cID conference ID
 @returns list of unsubscribed SuperSessions by the user of a given Conference, ordered by subscribed start date
 */
-(NSArray*)getUnsubscribedSuperSessionsByConferenceOrderedByDate: (NSString*) cID;

/**
 Unsubscribes all SuperSessions from a given Conference
 @param cID conference ID
 @returns true if succsessful, false if there is nos SuperSession subscribed from that conference in agenda
 */
-(BOOL)unsubscribeAllSuperSessionsFromAConf:(NSString*)cID;

/**
 Subscribes to agenda all SuperSessions from a given Conference
 @param cID conference ID
 */
-(void)subscribeAllSupserSessionsFromAConf:(NSString*)cID;

/**
 Returns all conferences
 @returns array of all conferences
 */
-(NSArray*)getAllConferences;

/**
 Returns subscribed conferences
 @returns array of all conferences
 */
-(NSArray*)getMyConferences;

/**
 Subscribe a conference
 @param c conference to add
 @returns true, if conference is added, false if it has already been added
 */
-(BOOL)addConference:(Conference*)c;

/**
 Removes a conference
 @param confID conference ID to remove
 @returns true, if the conference is deleted, false if is not subscribbed
 */
-(BOOL)removeConference:(NSString*)confID;

/**
 Fetch conferences from the server
 @returns true, if the the proceed worked as intended, false if there was a connection issue
 */
-(BOOL)fetchConferences;

/**
 Returns the list of conferences not subscribbed by the user
 @returns list of conferences not subscribbed by the user
 */
-(NSArray*)getRestOfConfs;

-(NSString*)getfetchedIDs;

-(BOOL)addConferenceWithID:(NSString*)confID;

-(void)updateConferences;

-(void)bootableConfs;
-(UIImage*)loadImageFromDrive:(NSString*)confID : (NSString*)imagePath;

-(NSArray*)getAllNewsOrderedByDate;
-(NSArray*)getAllNotifOrderedByDate;

-(Conference*)getConferenceWithID:(NSString*)cID;

@end
