//
//  Person.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Person.h"

@implementation Person

-(Person*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID{
    name = n;
    work = h;
    imagePath = imgPath;
    personID = pID;
    eventList = [[NSMutableArray alloc] init];
    return self;
}

-(NSString*)getName{
    return name;
}

-(NSString*)getWork{
    return work;
}

-(NSString*)getImagePath{
    return imagePath;
}

-(int)getID{
    return personID;
}

-(BOOL)addEvent:(int) eventID{
    BOOL isHere = false;
    for (int i=0; i<[eventList count]; i++) {
        if ([((NSNumber*)[eventList objectAtIndex:i]) intValue] == eventID){
            isHere = true;
            //break;
        }
    }
    if(isHere == false){
        [eventList addObject: [NSNumber numberWithInteger: eventID]];
        return true;
    }
    else return false;
}
-(NSArray*)getEventList{
    return eventList;
}

@end
