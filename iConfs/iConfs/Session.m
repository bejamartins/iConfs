//
//  Session.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Session.h"

@implementation Session

-(Session*)initWithDataAndSpeaker:(int)eID date:(NSDate*)d title:(NSString*)t theme:(NSString*)th speaker: (Speaker*)s athor: (Author*) a paper: (int)pID{
    eventID = eID;
    date = d;
    title = t;
    theme = th;
    speaker = s;
    author = a;
    paperID = pID;
    supersessions = [[NSMutableArray alloc] init];
    return self;
}

-(Author*)getAuthor{
    return author;
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
//the true ones
-(void)rateTrue:(float)r{
    ratingTrue = r;
}

-(float)getRateTrue{
    return ratingTrue;
}


-(NSDate*)getDate{
    return date;
}

-(void)setDate:(NSDate*)d{
    date = d;
}

-(int)getPaperID{
    return paperID;
}

- (NSComparisonResult)compare:(Event *)otherObject {
    return [[self getDate] compare:[otherObject getDate]];
}

@end
