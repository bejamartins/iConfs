//
//  Paper.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Paper.h"

@implementation Paper

-(Paper*)initWithData: (int) pID title:(NSString*) t authors: (NSArray*) a abstract:(NSString*)ab link:(NSString*) l{
    paperID = pID;
    title = t;
    authors = a;
    abstract = ab;
    link = l;
    return self;
}

-(NSString*)getTitle{
    return title;
}

-(NSArray*)getAuthors{
    return authors;
}

-(NSString*)getAbstract{
    return abstract;
}

-(int)getID{
    return paperID;
}

-(NSString*)getLink{
    return link;
}

-(void)setSession:(NSString*)sID{
    sessID = sID;
}
-(NSString*)getSessID{
    return sessID;
}

-(BOOL)addAuthor:(NSString*)authorID{
    BOOL isHere = false;
    for (int i=0; i<[authors count]; i++) {
        if ([((NSString*)[authors objectAtIndex:i]) isEqualToString:authorID]){
            isHere = true;
            //break;
        }
    }
    if(isHere == false){
        [authors addObject: authorID];
        return true;
    }
    else return false;
}


@end
