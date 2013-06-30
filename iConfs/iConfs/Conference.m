//
//  Conference.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 17/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Conference.h"

@implementation Conference

-(Conference*)initWithData: (NSString*)cID name: (NSString*)n image:(UIImage *)lp bluePrint:(NSMutableDictionary *)bp{
    //NSMutableDictionary *authors = [[NSMutableDictionary alloc] init];
    self.events = [[NSMutableDictionary alloc] init];
    self.news = [[NSMutableArray alloc] init];
    self.authors = [[NSMutableDictionary alloc] init];
    self.organizers = [[NSMutableDictionary alloc] init];
    self.speakers = [[NSMutableDictionary alloc] init];
    self.notifications = [[NSMutableArray alloc] init];
    self.bluePrints = [[NSMutableDictionary alloc] init];
    self.sessions = [[NSMutableArray alloc] init];
    self.workshops = [[NSMutableArray alloc] init];
    self.eventsList = [[NSMutableArray alloc] init];
    self.image = [[UIImage alloc] init];
    self.map = [[Map alloc] init];
    self.confID = cID;
    self.confName = n;
    self.image = lp;
    self.bluePrints = bp;
    supersessions = [[NSMutableDictionary alloc] init];
    return self;
}

-(BOOL)addAuthor:(Author*)author{
    
    /*NSNumber *value = [self.authors objectForKey:[NSNumber numberWithInteger: author.personID]];
    
    if (value)
    {
        return false;
    }
    else
    {*/
        [[self authors] setObject:author forKey: [NSNumber numberWithInteger: [author getID]]];
        return true;
    //}
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
    
   /* NSNumber *value = [self.organizers objectForKey:[NSNumber numberWithInteger: organizer.personID]];
    NSLog(organizers);
    if (value)
    {
        return false;
    }
    else
    {*/
        [[self organizers] setObject:organizer forKey:[NSNumber numberWithInteger: [organizer getID]]];
        return true;
    //}
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
    
    /*NSNumber *value = [[self speakers] objectForKey:[NSNumber numberWithInteger: [speaker personID]]];
    if (value!=NULL)
    {
        return false;
    }
    else
    {
        [self.speakers setObject:speaker forKey:[NSNumber numberWithInteger: speaker.personID]];
        return true;
    }*/

        [[self speakers] setObject:speaker forKey:[NSNumber numberWithInteger: [speaker getID]]];
        return true;

    
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
    return [self.speakers allValues];
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
    [news sortUsingSelector:@selector(compare:)];
    return [self.news copy];
}

-(BOOL)addNotification:(Notification*)notification{
    BOOL isHere = false;
    for (int i=0; i<[self.notifications count]; i++) {
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
    [notifications sortUsingSelector:@selector(compare:)];
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

-(void)changeLogo:(UIImage*)lp{
    self.image = lp;
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
    
-(NSString*)getID{
    return self.confID;
}

-(UIImage*)getLogo{
    return self.image;
}

-(NSString*)getName{
    return self.confName;
}

-(Map*) getMap{
    return map;
}

-(void) setMap: (Map*)newMap{
    map = newMap;
}


-(NSMutableDictionary*) getBlueprints{
    return self.bluePrints;
}

-(UIImage*)loadImage:(NSString*)confID : (NSString*)imagePath{
    
    NSString* imgPath=[NSString stringWithFormat:@"%@%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/",imagePath];
    
    NSData* imgData=[NSData dataWithContentsOfFile:imgPath options:kNilOptions error:NULL];
    UIImage* img;
    if (imgData == NULL)
        img = NULL;
    else
        img =[UIImage imageWithData:imgData];
    
    return img;
    
    
}

-(void)setSuperSessions:(NSMutableDictionary*)ss{
    supersessions = ss;
}

-(NSMutableDictionary*)getSuperSessions{
    return supersessions;
}

-(Author*)getAuthorByID:(int)pID{
    return [self.authors objectForKey:[NSNumber numberWithInteger: pID]];
}

-(Organizer*)getOrganizerByID:(int)pID{
    return [self.organizers objectForKey:[NSNumber numberWithInteger: pID]];
}

-(Speaker*)getSpeakerByID:(int)pID{
    return [self.authors objectForKey:[NSNumber numberWithInteger: pID]];
}


@end

