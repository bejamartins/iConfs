//
//  CustomizableSuperSession.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 24/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "CustomizableSuperSession.h"

@implementation CustomizableSuperSession

-(CustomizableSuperSession*)initWithData: (NSString*)sID theme: (NSString*)t{
    ssID = sID;
    theme = t;
    sessions = [[NSMutableArray alloc] init];
    workshops = [[NSMutableArray alloc] init];
    allEvents = [[NSMutableArray alloc] init];
    sessionsDic = [[NSMutableDictionary alloc] init];
    workshopsDic = [[NSMutableDictionary alloc] init];
    allEventsDic = [[NSMutableDictionary alloc] init];
    userSessionsDic = [[NSMutableDictionary alloc] init];
    userWorkshopsDic = [[NSMutableDictionary alloc] init];
    userAllEventsDic = [[NSMutableDictionary alloc] init];
    userSessions = [[NSMutableArray alloc] init];
    userWorkshops = [[NSMutableArray alloc] init];
    userAllEvents = [[NSMutableArray alloc] init];
    userStartDate = [[NSDate alloc] init];
    startDate = [[NSDate alloc] init];
    return self;
}

-(CustomizableSuperSession*)initWithSuperSession: (SuperSession*)ss{
    sessions = [[ss getSessionsOrderedByDate] mutableCopy];
    workshops = [[ss getWorkshopsOrderedByDate] mutableCopy];
    allEvents = [[ss getAllEventsOrderedByDate] mutableCopy];
    sessionsDic = [[ss getSessionsDicionary] mutableCopy];
    workshopsDic = [[ss getWorkshopsDicionary] mutableCopy];
    allEventsDic = [[ss getAllEventsDicionary] mutableCopy];
    startDate = [ss getStartDate];
    ssID = [ss getID];
    theme = [ss getTheme];
    userSessionsDic = [[NSMutableDictionary alloc] init];
    userWorkshopsDic = [[NSMutableDictionary alloc] init];
    userAllEventsDic = [[NSMutableDictionary alloc] init];
    userSessions = [[NSMutableArray alloc] init];
    userWorkshops = [[NSMutableArray alloc] init];
    userAllEvents = [[NSMutableArray alloc] init];
    userStartDate = [[NSDate alloc] init];
    return self;
}

-(void)subscribeAllEvents{
    userSessions = [sessions copy];
    userSessionsDic = [sessionsDic copy];
    userWorkshops = [workshops copy];
    userWorkshopsDic = [workshopsDic copy];
    userAllEvents = [allEvents copy];
    userAllEventsDic = [allEventsDic copy];
}

-(void)subscribeAllSessions{
    userSessions = [sessions copy];
    userSessionsDic = [sessionsDic copy];
    for (int i=0; i<[userSessions count]; i++) {
        [self subscribeOtherEvent:userSessions[i]];
    }
}

-(void)subscribeAllWorkshops{
    userWorkshops = [workshops copy];
    userWorkshopsDic = [workshopsDic copy];
    for (int i=0; i<[userSessions count]; i++) {
        [self subscribeOtherEvent:userSessions[i]];
    }
}

-(BOOL)subscribeOtherEvent:(Event*) e{
    if(([allEventsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] == nil) ||([userAllEventsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] != nil)){
        return false;
    }
    else{
        [userAllEvents addObject: e];
        [userAllEventsDic setObject:e forKey:[NSNumber numberWithInteger: [e getID]]];
        [userAllEvents sortUsingSelector:@selector(compare:)];
        userStartDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        return true;
    }
}

-(BOOL)subscribeSession:(Session*) e{
    if(([sessionsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] == nil) ||([userSessionsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] != nil)){
        return false;
    }
    else{
        [userAllEvents addObject: e];
        [userSessions addObject: e];
        [userAllEventsDic setObject:e forKey:[NSNumber numberWithInteger: [e getID]]];
        [userSessionsDic setObject:e forKey:[NSNumber numberWithInteger: [e getID]]];
        [userSessions sortUsingSelector:@selector(compare:)];
        [userAllEvents sortUsingSelector:@selector(compare:)];
        userStartDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        return true;
    }
}

-(BOOL)subscribeWorksop:(EventWorkshop*) e{
    if(([workshopsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] == nil) ||([userWorkshopsDic objectForKey:[NSNumber numberWithInteger: [e getID]]] != nil)){
        return false;
    }
    else{
        [userAllEvents addObject: e];
        [userWorkshops addObject: e];
        [userAllEventsDic setObject:e forKey:[NSNumber numberWithInteger: [e getID]]];
        [userWorkshopsDic setObject:e forKey:[NSNumber numberWithInteger: [e getID]]];
        [userWorkshops sortUsingSelector:@selector(compare:)];
        [userAllEvents sortUsingSelector:@selector(compare:)];
        userStartDate = [((Event*)[allEvents objectAtIndex:0]) getDate];
        return true;
    }
}

-(BOOL)unsubscribeSession:(int)sessionID{
    if([userSessionsDic objectForKey:[NSNumber numberWithInteger: sessionID]] == nil){
        return false;
    }
    else{
        Session* s = [userSessionsDic objectForKey:[NSNumber numberWithInteger: sessionID]];
        [userSessions removeObject:s];
        [userAllEvents removeObject: s];
        [userSessionsDic removeObjectForKey:[NSNumber numberWithInteger: sessionID]];
        [userAllEventsDic removeObjectForKey:[NSNumber numberWithInteger: sessionID]];
        [userSessions sortUsingSelector:@selector(compare:)];
        [userAllEvents sortUsingSelector:@selector(compare:)];
        if([userAllEvents count] != 0){
            userStartDate = [((Event*)[userAllEvents objectAtIndex:0]) getDate];
        }
        else{
            userStartDate = nil;
        }
        return true;
    }
}

-(BOOL)unsubscribeWorkshop:(int)workshopID{
    if([userWorkshopsDic objectForKey:[NSNumber numberWithInteger: workshopID]] == nil){
        return false;
    }
    else{
        EventWorkshop* s = [userWorkshopsDic objectForKey:[NSNumber numberWithInteger: workshopID]];
        [userWorkshops removeObject:s];
        [userAllEvents removeObject: s];
        [userWorkshopsDic removeObjectForKey:[NSNumber numberWithInteger: workshopID]];
        [userAllEventsDic removeObjectForKey:[NSNumber numberWithInteger: workshopID]];
        [userWorkshops sortUsingSelector:@selector(compare:)];
        [userAllEvents sortUsingSelector:@selector(compare:)];
        if([userAllEvents count] != 0){
            userStartDate = [((Event*)[userAllEvents objectAtIndex:0]) getDate];
        }
        else{
            userStartDate = nil;
        }
        return true;
    }
}

-(BOOL)unsubscribeOtherEvent:(int)eventID{
    if([userAllEventsDic objectForKey:[NSNumber numberWithInteger: eventID]] == nil){
        return false;
    }
    else{
        Event* s = [userAllEventsDic objectForKey:[NSNumber numberWithInteger: eventID]];
        [userAllEvents removeObject: s];
        [userAllEventsDic removeObjectForKey:[NSNumber numberWithInteger: eventID]];
        [userAllEvents sortUsingSelector:@selector(compare:)];
        if([userAllEvents count] != 0){
            userStartDate = [((Event*)[userAllEvents objectAtIndex:0]) getDate];
        }
        else{
            userStartDate = nil;
        }
        return true;
    }
}


-(NSDate*)getUserStartDate{
    return userStartDate;
}

-(NSDictionary*)getUserSessionsDicionary{
    return userSessionsDic;
}

-(NSDictionary*)getUserWorkshopsDicionary{
    return userWorkshopsDic;
}

-(NSDictionary*)getUserAllEventsDicionary{
    return userAllEventsDic;
}

-(NSArray*)getUserSessionsOrderedByDate{
    return userSessions;
}

-(NSArray*)getUserWorkshopsOrderedByDate{
    return userWorkshops;
}

-(NSArray*)getUserAllEventsOrderedByDate{
    return userAllEvents;
}

-(NSArray*)getUnsubscribedEvents{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    int a;
    for (int i=0; i<[allEvents count]; i++) {
        a = [(Event*)[allEvents objectAtIndex:i] getID];
        if([userAllEventsDic objectForKey:[NSNumber numberWithInteger: a]] == nil){
            [ret addObject: [allEvents objectAtIndex:i]];
        }
    }
    return ret;
    
}

-(NSArray*)getUnsubscribedSessions{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    int a;
    for (int i=0; i<[sessions count]; i++) {
        a = [(Session*)[sessions objectAtIndex:i] getID];
        if([userSessionsDic objectForKey:[NSNumber numberWithInteger: a]] == nil){
            [ret addObject: [sessions objectAtIndex:i]];
        }
    }
    return ret;
    
}

-(NSArray*)getUnsubscribedWorkshops{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    int a;
    for (int i=0; i<[workshops count]; i++) {
        a = [(EventWorkshop*)[workshops objectAtIndex:i] getID];
        if([userWorkshopsDic objectForKey:[NSNumber numberWithInteger: a]] == nil){
            [ret addObject: [workshops objectAtIndex:i]];
        }
    }
    return ret;
    
}

-(NSComparisonResult)compare:(CustomizableSuperSession *)otherObject{
    return [[self getUserStartDate] compare:[otherObject getUserStartDate]];
}

@end
