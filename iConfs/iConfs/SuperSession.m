//
//  SuperSession.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 22/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "SuperSession.h"

@implementation SuperSession

-(SuperSession*)initWithData: (NSString*)sID theme: (NSString*)t{
    ssID = sID;
    theme = t;
    sessions = [[NSMutableArray alloc] init];
    workshops = [[NSMutableArray alloc] init];;
    allEvents = [[NSMutableArray alloc] init];;
    sessionsDic = [[NSMutableDictionary alloc] init];
    workshopsDic = [[NSMutableDictionary alloc] init];
    allEventsDic = [[NSMutableDictionary alloc] init];
    startDate = [[NSDate alloc] init];
    return self;
}


-(BOOL)addSession: (Session*)s{
    if([sessionsDic objectForKey:[NSNumber numberWithInteger: [s getID]]] != nil){
        return false;
    }
    else{
        [sessions addObject: s];
        [allEvents addObject: s];
        [sessionsDic setObject:s forKey:[NSNumber numberWithInteger: [s getID]]];
        [allEventsDic setObject:s forKey:[NSNumber numberWithInteger: [s getID]]];
        [sessions sortUsingSelector:@selector(compare:)];
        [allEvents sortUsingSelector:@selector(compare:)];
        startDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        return true;
    }
}

-(BOOL)addWorkshop: (EventWorkshop*)w{
    if([workshopsDic objectForKey:[NSNumber numberWithInteger: [w getID]]] != nil){
        return false;
    }
    else{
        [workshops addObject: w];
        [allEvents addObject: w];
        [workshopsDic setObject:w forKey:[NSNumber numberWithInteger: [w getID]]];
        [allEventsDic setObject:w forKey:[NSNumber numberWithInteger: [w getID]]];
        [workshops sortUsingSelector:@selector(compare:)];
        [allEvents sortUsingSelector:@selector(compare:)];
        startDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        return true;
    }
}

-(BOOL)addOtherEvent: (Event*)e{
    if([allEventsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] != nil){
        return false;
    }
    else{
        [allEvents addObject: e];
        [allEventsDic setObject:e forKey:[NSNumber numberWithInteger: [e getID]]];
        [allEvents sortUsingSelector:@selector(compare:)];
        startDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        return true;
    }
}

-(NSArray*)getSessionsOrderedByDate{
    return sessions;
}

-(NSArray*)getWorkshopsOrderedByDate{
    return workshops;
}

-(NSArray*)getAllEventsOrderedByDate{
    return allEvents;
}

-(BOOL)removeSession:(int)sessionID{
    if([sessionsDic objectForKey:[NSNumber numberWithInteger: sessionID]] == nil){
        return false;
    }
    else{
        Session* s = [sessionsDic objectForKey:[NSNumber numberWithInteger: sessionID]];
        [sessions removeObject:s];
        [allEvents removeObject: s];
        [sessionsDic removeObjectForKey:[NSNumber numberWithInteger: sessionID]];
        [allEventsDic removeObjectForKey:[NSNumber numberWithInteger: sessionID]];
        [sessions sortUsingSelector:@selector(compare:)];
        [allEvents sortUsingSelector:@selector(compare:)];
        if([allEvents count] != 0){
            startDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        }
        else{
            startDate = nil;
        }
        return true;
    }
}

-(BOOL)removeWorkshop:(int)workshopID{
    if([workshopsDic objectForKey:[NSNumber numberWithInteger: workshopID]] == nil){
        return false;
    }
    else{
        EventWorkshop* s = [workshopsDic objectForKey:[NSNumber numberWithInteger: workshopID]];
        [workshops removeObject:s];
        [allEvents removeObject: s];
        [workshopsDic removeObjectForKey:[NSNumber numberWithInteger: workshopID]];
        [allEventsDic removeObjectForKey:[NSNumber numberWithInteger: workshopID]];
        [workshops sortUsingSelector:@selector(compare:)];
        [allEvents sortUsingSelector:@selector(compare:)];
        if([allEvents count] != 0){
            startDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        }
        else{
            startDate = nil;
        }
        return true;
    }
}

-(BOOL)removeOtherEvent:(int)eventID{
    if([allEventsDic objectForKey:[NSNumber numberWithInteger: eventID]] == nil){
        return false;
    }
    else{
        Event* s = [allEventsDic objectForKey:[NSNumber numberWithInteger: eventID]];
        [allEvents removeObject: s];
        [allEventsDic removeObjectForKey:[NSNumber numberWithInteger: eventID]];
        [allEvents sortUsingSelector:@selector(compare:)];
        if([allEvents count] != 0){
            startDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        }
        else{
            startDate = nil;
        }
        return true;
    }
}

-(NSDate*)getStartDate{
    return startDate;
}

-(NSDictionary*)getSessionsDicionary{
    return sessionsDic;
}

-(NSDictionary*)getWorkshopsDicionary{
    return workshopsDic;
}

-(NSDictionary*)getAllEventsDicionary{
    return allEventsDic;
}

-(NSString*)getID{
    return ssID;
}

-(NSString*)getTheme{
    return theme;
}

-(NSComparisonResult)compare:(SuperSession *)otherObject{
    return [[self getStartDate] compare:[otherObject getStartDate]];
}

@end
