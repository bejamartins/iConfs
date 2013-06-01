//
//  Event.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Speaker.h"

@interface Event : NSObject
{
    @protected
    NSDate* date;
    NSString* title;
    NSString* theme;
    Speaker* speaker;
    BOOL userVoted;
    int vote;
    int rating;
    int eventID;
}

//Date and time of the event
@property (nonatomic) NSDate* date;

//Title of the event
@property (nonatomic) NSString* title;

//Theme of the event
@property (nonatomic) NSString* theme;

//Speaker of the event
@property (nonatomic) Speaker* speaker;

//Check if the user has voted
@property (nonatomic) BOOL userVoted;

//Rating of the event by the user
@property (nonatomic) int vote;

//Overall rating of the event
@property (nonatomic) int rating;

//ID of the event
@property (nonatomic) int eventID;

/**
 Initializes a new Event object
 @param eID id of the event
 @param d date and time of the event
 @param t title of the event
 @param th theme of the event
 @returns a newly initialized object
 */
-(Event*)initWithData:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th;

/**
 Initializes a new Event object with Speaker
 @param eID id of the event
 @param d date and time of the event
 @param t title of the event
 @param th theme of the event
 @param s spearker of the event
 @returns a newly initialized object
 */
-(Event*)initWithDataAndSpeaker:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th speaker: (Speaker*)s;

/**
 Preforms a user vote
 @param v user vote
 @returns
 */
-(void)vote:(int)v;

/**
 Gets event title
 @returns event's title
 */
-(NSString*)getTitle;

/**
 Gets event ID
 @returns event's ID
 */
-(int)getID;

/**
 Gets event theme
 @returns event's theme
 */
-(NSString*)getTheme;

/**
 Gets event speaker
 @returns event's speaker
 */
-(Speaker*)getSpeaker;

/**
 Sets event speaker
 @param s new event speaker
 @returns 
 */
-(void)setSpeaker:(Speaker*)s;

/**
 Gets user's vote
 @returns user's vote or -1 if user hasn't voted on the event
 */
-(int)getVote;

/**
 Inserts overal event rating
 @param r rating
 @returns 
 */
-(void)rate:(int)r;

/**
 Gets event's overall rating
 @returns rating or -1 if there are no votes on the event
 */
-(int)getRate;

/**
 Gets event's overall rating
 @returns rating or -1 if there are no votes on the event
 */
-(NSDate*)getDate;

/**
 Sets event's date and tume
 @param d nem date and time
 @returns 
 */
-(void)setDate:(NSDate*)d;


@end
