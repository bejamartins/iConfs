//
//  Author.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "Author.h"

@implementation Author

-(Author*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID{
    name = n;
    work = h;
    imagePath = imgPath;
    personID = pID;
    return self;
}


-(Paper*)getPaper:(int)paperID{
    NSNumber *value = [papers objectForKey:[NSNumber numberWithInteger: paperID]];
    
    if (value)
    {
        return ((Paper*)[papers objectForKey:[NSNumber numberWithInteger: paperID]]);
    }
    else
    {
        return NULL;
    }
}

-(NSArray*)getAllPapers{
    return [papers allValues];
}

-(BOOL)addPapper:(Paper*)p{
    NSNumber *value = [papers objectForKey:[NSNumber numberWithInteger: p.getID]];
    
    if (value)
    {
        return false;
    }
    else
    {
        [papers setObject:p forKey:[NSNumber numberWithInteger: p.getID]];
        return true;
    }
}

-(BOOL)removePaper:(int)paperID{
    NSNumber *value = [papers objectForKey:[NSNumber numberWithInteger: paperID]];
    
    if (value)
    {
        [papers removeObjectForKey:[NSNumber numberWithInteger: paperID]];
        return true;
    }
    else
    {
        return false;
    }
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

-(NSString*)getSessID{
    return sessID;
}
-(void)setConfID: (NSString*)newSID{
    sessID = newSID;
}

//dado o confID e a variavel paperPath (ex.: @"paper.pdf")
//devolve o caminho absoluto ate ao ficheiro
-(NSString*)getPaper:(NSString*)confID : (NSString*)paperPath{
    
    return [NSString stringWithFormat:@"%@%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/",paperPath];
    
}


@end
