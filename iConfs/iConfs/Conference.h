//
//  Conference.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 17/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
#import "Organizer.h"
#import "Speaker.h"
#import "News.h"
#import "Notification.h"
#import "EventWorkshop.h"
#import "Session.h"

//@class Workshop;

@interface Conference : NSObject
{
@protected
    NSString* logo_path;
    int confID;
    NSString* confName;
    NSMutableDictionary* events;
    NSMutableArray* news;
    NSMutableDictionary* authors;
    NSMutableDictionary* organizers;
    NSMutableDictionary* speakers;
    NSMutableArray* notifications;
    NSMutableDictionary* bluePrints;
    NSMutableArray* sessions;
    NSMutableArray* workshops;
    NSMutableArray* eventsList;
    
}

//Path to the logo of the conference
@property (nonatomic) NSString* logo_path;

//ID of the conference
@property (nonatomic) int confID;

//Name of he conference
@property (nonatomic) NSString* confName;

//Dictiornary of the conference events
@property (nonatomic) NSMutableDictionary* events;

//Dictiornary of the conference news
@property (nonatomic) NSMutableArray* news;

//Dictiornary of the conference authors
@property (nonatomic) NSMutableDictionary* authors;

//Dictiornary of the conference organizers
@property (nonatomic) NSMutableDictionary* organizers;

//Dictiornary of the conference speakers
@property (nonatomic) NSMutableDictionary* speakers;

//Array of the conference notifications
@property (nonatomic) NSMutableArray* notifications;

//Dictiornary of the conference blueprints
@property (nonatomic) NSMutableDictionary* bluePrints;

//Array of the conference sessions
@property (nonatomic) NSMutableArray* sessions;

//Array of the conference workshops
@property (nonatomic) NSMutableArray* workshops;

//Array of the conference non-session nor workshop events
@property (nonatomic) NSMutableArray* eventsList;


/**
 Initializes a new Conference object
 @param cID id of the conference
 @param n Name of the conference
 @param logo_path the path to the corresponding conference logo
 @param bp list of path to the blueprints of the conference floors
 @returns a newly initialized object
 */
-(Conference*)initWithData: (int)cID name: (NSString*)n logo_path:(NSString*)lp bluePrint:(NSMutableDictionary*)bp;

/**
 Adds an author to the conference
 @param author author to add
 @returns true if the author has been added, false if it already is in the conference
 */
-(BOOL)addAuthor:(Author*)author;

/**
 Removes an author to the conference
 @param personID author's ID to remove
 @returns true if the author has been removed, false if wasn't on the conference
 */
-(BOOL)removePerson:(int)personID;

/**
 Returns an non-mutable array with all the authors from the conference
 @returns array of authors
 */
-(NSArray*)getAuthors;

/**
 Adds an organizer to the conference
 @param organizer organizer to add
 @returns true if the organizer has been added, false if it already is in the conference
 */
-(BOOL)addOrganizer:(Organizer*)organizer;

/**
 Removes an organizer to the conference
 @param personID organizer's ID to remove
 @returns true if the organizer has been removed, false if wasn't on the conference
 */
-(BOOL)removeOrganizer:(int)personID;

/**
 Returns an non-mutable array with all the organizers from the conference
 @returns array of organizers
 */
-(NSArray*)getOrganizers;

/**
 Adds a speaker to the conference
 @param speaker speaker to add
 @returns true if the speaker has been added, false if it already is in the conference
 */
-(BOOL)addSpeaker:(Speaker*)speaker;

/**
 Removes a speaker from the conference
 @param personID speaker's ID to remove
 @returns true if the speaker has been removed, false if wasn't on the conference
 */
-(BOOL)removeSpeaker:(int)personID;

/**
 Returns an non-mutable array with all the speakers from the conference
 @returns array of speakers
 */
-(NSArray*)getSpeakers;

/**
 Adds news to the conference
 @param n news to add
 @returns true if the news have been added, false it had already been added
 */
-(BOOL)addNews:(News*)n;

/**
 Returns an non-mutable array with all the news from the conference
 @returns array of news
 */
-(NSArray*)getNews;

/**
 Adds a notification to the conference
 @param notification notification to add
 @returns true if the notification has been added, false it had already been added
 */
-(BOOL)addNotification:(Notification*)notification;

/**
 Returns an non-mutable array with all the notifications from the conference
 @returns array of notifications
 */
-(NSArray*)getNotifications;

/**
 Adds a session to the conference
 @param session session to add
 @returns true if the session has been added, false it had already been added
 */
-(BOOL)addSessions:(Session*)session;

/**
 Removes a workshop from the conference
 @param eventID event's ID to remove
 @returns true if the event has been removed, false if wasn't on the conference
 */
-(BOOL)removeSession:(int)eventID;

/**
 Returns an non-mutable array with all the sessions from the conference
 @returns array of sessions
 */
-(NSArray*)getSessions;

/**
 Adds a workshop to the conference
 @param workshop workshop to add
 @returns true if the workshop has been added, false it had already been added
 */
-(BOOL)addWorkshop:(EventWorkshop*)workshop;

/**
 Removes a workshop from the conference
 @param eventID event's ID to remove
 @returns true if the event has been removed, false if wasn't on the conference
 */
-(BOOL)removeWorkshop:(int)eventID;

/**
 Returns an non-mutable array with all the workshops from the conference
 @returns array of workshops
 */
-(NSArray*)getWorkshops;

/**
 Adds an other kind of event to the conference
 @param event event to add
 @returns true if the session has been added, false it had already been added
 */
-(BOOL)addOtherEvent:(Event*)event;

/**
 Removes an event (excluding sessions or workshops) from the conference
 @param eventID event's ID to remove
 @returns true if the event has been removed, false if wasn't on the conference
 */
-(BOOL)removeOtherEvent:(int)eventID;

/**
 Returns an non-mutable array with all the other events (non-sessions nor workshops) from the conference
 @returns array of notifications
 */
-(NSArray*)getAllEvents;

/**
 Changes the logo path of the conference
 @param lp new logo path
 @returns
 */
-(void)changeLogoPath:(NSString*)lp;

/**
 Changes the conference name
 @param n new conference name
 @returns
 */
-(void)changeConferenceName:(NSString*)n;

/**
 Changes the blue print of a given floor of the conference
 @param floor floor number
 @param file_path new file path for the floor
 @returns true if the floor has been changed, false if otherwise
 */
-(BOOL)changeBluePrint:(int)floor file_path:(NSString*)fp;

/**
 Removes the blue print of a given floor of the conference
 @param floor floor number
 @returns true if the floor has been removed, false if the floor blueprint didn't exist
 */
-(BOOL)deleteBluePrint:(int)floor;

/**
 Gets conference ID
 @returns conference ID
 */
-(int)getID;

@end

