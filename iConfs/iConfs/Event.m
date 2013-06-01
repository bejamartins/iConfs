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

@end
