//
//  News.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 17/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "News.h"

@implementation News

-(News*)initWithData: (NSString*)nID title:(NSString*) t text: (NSString*) txt date:(NSDate*)date{
    self.title = t;
    self.text = txt;
    self.sentDate = date;
    newsID = nID;
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
    return newsID;
}

-(NSComparisonResult)compare:(News *)otherObject {
    return [[self sentDate] compare:[otherObject sentDate]];
}

-(void)setConfID:(NSString*)cID{
    confID = cID;
}

-(NSString*)getConfID{
    return confID;
}

@end

