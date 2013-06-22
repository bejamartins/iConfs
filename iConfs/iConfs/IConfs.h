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

@interface IConfs : AppDataObject
{
    @protected
    NSMutableArray* conferences;
    NSMutableArray* allConferences;
    NSMutableArray* agenda;
    NSMutableDictionary* conferencesDic;
    NSMutableDictionary* allConferencesDic;
    NSMutableArray* addedConfsIDs;
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
-(BOOL)addEventToAgenda:(Event*)event;

/**
 Removes the event from the agenda
 @param eventID event ID to remove
 @returns true, if event is deleted, false if is not in the agenda
 */
-(BOOL)removeEventFromAgenda:(int)eventID;

/**
 Returns the agenda array of events
 @returns array of agenda events
 */
-(NSArray*)getAgenda;

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

@end
