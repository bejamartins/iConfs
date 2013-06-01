//
//  Conference.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 17/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Conference.h"

@implementation Conference

-(Conference*)initWithData: (int)cID name: (NSString*)n logo_path:(NSString*)lp bluePrint:(NSMutableDictionary*)bp{
    self.confID = cID;
    self.confName = n;
    self.logo_path = lp;
    self.bluePrints = bp;
    //NSMutableDictionary *authors = [[NSMutableDictionary alloc] init];
    return self;
}

-(BOOL)addAuthor:(Author*)author{
    
    NSNumber *value = [self.authors objectForKey:[NSNumber numberWithInteger: author.personID]];
    
    if (value)
    {
        return false;
    }
    else
    {
        [self.authors setObject:author forKey: [NSNumber numberWithInteger: author.personID]];
        return true;
    }
}


-(BOOL)removePerson:(int)personID{
    
    NSNumber *value = [self.authors objectForKey:[NSNumber numberWithInteger: personID]];
    
    if (value)
    {
        [self.authors removeObjectForKey:[NSNumber numberWithInteger: personID]];
        return true;
    }
    else
    {
        return false;
    }
}

-(NSArray*)getAuthors{
    return [self.authors allValues];
}

-(BOOL)addOrganizer:(Organizer*)organizer{
    
    NSNumber *value = [self.organizers objectForKey:[NSNumber numberWithInteger: organizer.personID]];
    
    if (value)
    {
        return false;
    }
    else
    {
        [self.organizers setObject:organizer forKey:[NSNumber numberWithInteger: organizer.personID]];
        return true;
    }
}

-(BOOL)removeOrganizer:(int)personID{
    
    NSNumber *value = [self.organizers objectForKey:[NSNumber numberWithInteger: personID]];
    
    if (value)
    {
        [self.organizers removeObjectForKey:[NSNumber numberWithInteger: personID]];
        return true;
    }
    else
    {
        return false;
    }
}

-(NSArray*)getOrganizers{
    return [self.organizers allValues];
}

-(BOOL)addSpeaker:(Speaker*)speaker{
    
    NSNumber *value = [self.speakers objectForKey:[NSNumber numberWithInteger: speaker.personID]];
    
    if (value)
    {
        return false;
    }
    else
    {
        [self.speakers setObject:speaker forKey:[NSNumber numberWithInteger: speaker.personID]];
        return true;
    }
    
}

-(BOOL)removeSpeaker:(int)personID{
    
    NSNumber *value = [self.speakers objectForKey:[NSNumber numberWithInteger: personID]];
    
    if (value)
    {
        [self.speakers removeObjectForKey:[NSNumber numberWithInteger: personID]];
        return true;
    }
    else
    {
        return false;
    }
    
}

-(NSArray*)getSpeakers{
    return [self.organizers allValues];
}

-(BOOL)addNews:(News*)n{
    BOOL isHere = false;
    for (int i=0; i<[self.news count]; i++) {
        if ([((News*)[self.news objectAtIndex:i]).getTitle isEqual: n.getTitle] && [((News*)[self.news objectAtIndex:i]).getDate isEqual: n.getDate]){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [self.news addObject: n];
        return true;
    }
    else return false;
}

-(NSArray*)getNews{
    return [self.news copy];
}

-(BOOL)addNotification:(Notification*)notification{
    BOOL isHere = false;
    for (int i=0; i<[self.news count]; i++) {
        if ([((Notification*)[self.notifications objectAtIndex:i]).getTitle isEqual: notification.getTitle] && [((Notification*)[self.notifications objectAtIndex:i]).getDate isEqual: notification.getDate]){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [self.notifications addObject: notification];
        return true;
    }
    else return false;
}

-(NSArray*)getNotifications{
    return [self.notifications copy];
}

-(BOOL)addSessions:(Session*)session{
    BOOL isHere = false;
    for (int i=0; i<[self.sessions count]; i++) {
        if (((Session*)[self.sessions objectAtIndex:i]).getID == session.getID){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [self.sessions addObject: session];
        return true;
    }
    else return false;
}

-(BOOL)removeSession:(int)eventID{
    BOOL isHere = false;
    //NSObject toRemove;
    int index;
    for (int i=0; i<[self.sessions count]; i++) {
        if (((Session*)[self.sessions objectAtIndex:i]).getID == eventID){
            isHere = true;
            //toRemove = [self.sessions objectAtIndex:i];
            index = i;
            break;
        }
    }
    if(isHere == true){
        //[self.sessions removeObject: toRemove];
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        [mutableIndexSet addIndex:index];
        [self.sessions removeObjectsAtIndexes:mutableIndexSet];
        return true;
    }
    else return false;
}

-(NSArray*)getSessions{
    return [self.sessions copy];
}

-(BOOL)addWorkshop:(EventWorkshop*)workshop{
    BOOL isHere = false;
    for (int i=0; i<[self.news count]; i++) {
        if (((EventWorkshop*)[self.workshops objectAtIndex:i]).getID == workshop.getID){
            isHere = true;
            //break;
        }
    }
    if(isHere == false){
        [self.workshops addObject: workshop];
        return true;
    }
    else return false;
}

-(BOOL)removeWorkshop:(int)eventID{
    BOOL isHere = false;
    //NSObject toRemove;
    int index;
    for (int i=0; i<[self.news count]; i++) {
        if (((EventWorkshop*)[self.workshops objectAtIndex:i]).getID == eventID){
            isHere = true;
            //toRemove = [self.sessions objectAtIndex:i];
            index = i;
            break;
        }
    }
    if(isHere == true){
        //[self.sessions removeObject: toRemove];
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        [mutableIndexSet addIndex:index];
        [self.workshops removeObjectsAtIndexes:mutableIndexSet];
        return true;
    }
    else return false;
}

-(NSArray*)getWorkshops{
    return [self.workshops copy];
}

-(BOOL)addOtherEvent:(Event*)event{
    BOOL isHere = false;
    for (int i=0; i<[self.news count]; i++) {
        if (((Event*)[self.eventsList objectAtIndex:i]).getID == event.getID){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [self.eventsList addObject: event];
        return true;
    }
    else return false;
}

-(BOOL)removeOtherEvent:(int)eventID{
    BOOL isHere = false;
    //NSObject toRemove;
    int index;
    for (int i=0; i<[self.news count]; i++) {
        if (((Event*)[self.eventsList objectAtIndex:i]).getID == eventID){
            isHere = true;
            //toRemove = [self.sessions objectAtIndex:i];
            index = i;
            break;
        }
    }
    if(isHere == true){
        //[self.sessions removeObject: toRemove];
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        [mutableIndexSet addIndex:index];
        [self.eventsList removeObjectsAtIndexes:mutableIndexSet];
        return true;
    }
    else return false;
}

-(NSArray*)getAllEvents{
    return [self.eventsList copy];
}

-(void)changeLogoPath:(NSString*)lp{
    self.logo_path = lp;
}

-(void)changeConferenceName:(NSString*)n{
    self.confName = n;
}

-(BOOL)changeBluePrint:(int)floor file_path:(NSString*)fp{
    [self.bluePrints setObject:fp forKey:[NSNumber numberWithInteger: floor]];
    return true;
}

-(BOOL)deleteBluePrint:(int)floor{
    NSNumber *value = [self.bluePrints objectForKey:[NSNumber numberWithInteger: floor]];
    
    if (value)
    {
        [self.bluePrints removeObjectForKey:[NSNumber numberWithInteger: floor]];
        return true;
    }
    else
    {
        return false;
    }
}
    
-(int)getID{
    return confID;
}

@end

