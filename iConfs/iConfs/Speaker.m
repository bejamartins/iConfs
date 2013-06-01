//
//  Speaker.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Speaker.h"

@implementation Speaker

-(Speaker*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID resume: (NSString*)r{
    name = n;
    work = h;
    imagePath = imgPath;
    personID = pID;
    resume = r;
    return self;
}

-(NSString*)getResume{
    return resume;
}

-(void)setResume:(NSString*)r{
    resume = r;
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
