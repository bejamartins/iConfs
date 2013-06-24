//
//  Event.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Event.h"

@implementation Event

-(Event*)initWithData:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th{
    eventID = eID;
    date = d;
    title = t;
    theme = th;
    vote = -1;
    rating = -1;
    supersessions = [[NSMutableArray alloc] init];
    return self;
}

-(Event*)initWithDataAndSpeaker:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th speaker: (Speaker*)s{
    eventID = eID;
    date = d;
    title = t;
    theme = th;
    speaker = s;
    vote = -1;
    rating = -1;
    supersessions = [[NSMutableArray alloc] init];
    return self;
}

-(void)vote:(int)v{
    vote = v;
}

-(NSString*)getTitle{
    return title;
}

-(int)getID{
    return eventID;
}

-(NSString*)getTheme{
    return theme;
}

-(Speaker*)getSpeaker{
    return speaker;
}

-(void)setSpeaker:(Speaker*)s{
    speaker = s;
}

-(void)setVote:(int)v{
    vote = v;
}

-(int)getVote{
    return vote;
}

-(void)rate:(int)r{
    rating = r;
}

-(int)getRate{
    return rating;
}

-(NSDate*)getDate{
    return date;
}

-(void)setDate:(NSDate*)d{
    date = d;
}

-(NSString*)getPlaceID{
    return placeID;
}

-(void)setPlaceID:(NSString*)newPlaceID{
    placeID = newPlaceID;
}

-(void)setEventEnd:(NSDate*)end{
    eventEnd = end;
}

-(NSDate*)getEventEnd{
    return eventEnd;
}

-(NSComparisonResult)compare:(Event *)otherObject {
    return [[self getDate] compare:[otherObject getDate]];
}

-(BOOL)addSuperSession:(NSString*)superSessionID{
    BOOL isHere = false;
    for (int i=0; i<[supersessions count]; i++) {
        if ([((NSString*)[supersessions objectAtIndex:i]) isEqualToString:superSessionID]){
            isHere = true;
            //break;
        }
    }
    if(isHere == false){
        [supersessions addObject: superSessionID];
        return true;
    }
    else return false;
}

-(NSArray*)getSuperSessions{
    return supersessions;
}


@end
