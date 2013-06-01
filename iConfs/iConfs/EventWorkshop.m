//
//  EventWorkshop.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "EventWorkshop.h"

@implementation EventWorkshop

-(EventWorkshop*)initWithDataAndSpeaker:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th speaker:(Speaker*)s needs:(NSString*)n{
    eventID = eID;
    date = d;
    title = t;
    theme = th;
    speaker = s;
    needs = n;
    return self;
}
-(NSString*)getNeeds{
    return needs;
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
