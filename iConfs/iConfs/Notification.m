//
//  Notification.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Notification.h"

@implementation Notification

-(Notification*)initWithData: (NSString*)nID title:(NSString*) t text: (NSString*) txt date:(NSDate*)date{
    self.title = t;
    self.text = txt;
    self.sentDate = date;
    notifID = nID;
    return self;
}
-(NSString*)getTitle{
    return self.title;
}
-(NSString*)getText{
    return self.text;
}
-(NSDate*)getDate{
    return self.sentDate;
}

-(NSString*)getID{
    return notifID;
}

-(NSComparisonResult)compare:(Notification *)otherObject {
    return [[self sentDate] compare:[otherObject sentDate]];
}

@end
