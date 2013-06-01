//
//  Organizer.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Organizer.h"

@implementation Organizer

-(Organizer*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID job: (NSString*)j{
    name = n;
    work = h;
    imagePath = imgPath;
    personID = pID;
    job = j;
    return self;
}

-(NSString*)getJob{
    return job;
}

-(void)setjob:(NSString*)j{
    job = j;
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

@end
