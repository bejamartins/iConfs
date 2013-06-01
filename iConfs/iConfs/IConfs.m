//
//  IConfs.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "IConfs.h"

@implementation IConfs


-(IConfs*)initiConfs: (NSArray*)aConferences{
    allConferences = [aConferences copy];
    return self;
}

-(BOOL)addEventToAgenda:(Event*)event{
    BOOL isHere = false;
    for (int i=0; i<[agenda count]; i++) {
        if (((Event*)[agenda objectAtIndex:i]).getID == event.getID){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [agenda addObject: event];
        return true;
    }
    else return false;
}

-(BOOL)removeEventFromAgenda:(int)eventID{
    BOOL isHere = false;
    int index;
    for (int i=0; i<[agenda count]; i++) {
        if (((Event*)[agenda objectAtIndex:i]).getID == eventID){
            isHere = true;
            index = i;
            break;
        }
    }
    if(isHere == true){
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        [mutableIndexSet addIndex:index];
        [agenda removeObjectsAtIndexes:mutableIndexSet];
        return true;
    }
    else return false;
}

-(NSArray*)getAgenda{
    return [agenda copy];
}


-(NSArray*)getAllConferences{
    return [allConferences copy];
}


-(NSArray*)getMyConferences{
    return [conferences copy];
}


-(BOOL)addConference:(Conference*)c{
    BOOL isHere = false;
    for (int i=0; i<[agenda count]; i++) {
        if (((Conference*)[conferences objectAtIndex:i]).getID == c.getID){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [conferences addObject: c];
        return true;
    }
    else return false;
}


-(BOOL)removeConference:(int)confID{
    BOOL isHere = false;
    //NSObject toRemove;
    int index;
    for (int i=0; i<[conferences count]; i++) {
        if (((Event*)[conferences objectAtIndex:i]).getID == confID){
            isHere = true;
            index = i;
            break;
        }
    }
    if(isHere == true){
        NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
        [mutableIndexSet addIndex:index];
        [conferences removeObjectsAtIndexes:mutableIndexSet];
        return true;
    }
    else return false;
}

@end