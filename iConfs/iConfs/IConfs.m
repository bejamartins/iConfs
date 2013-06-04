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
    for (int i=0; i<[conferences count]; i++) {
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

-(BOOL)addToAllConference:(Conference*)c{
    BOOL isHere = false;
    for (int i=0; i<[allConferences count]; i++) {
        if (((Conference*)[allConferences objectAtIndex:i]).getID == c.getID){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [allConferences addObject: c];
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

//get array with confs IDs
//use dictionary from getConfs
-(NSArray *)getConfsIDFromServer:(NSDictionary *)confsRaw{
    NSArray *array=[confsRaw valueForKey:@"ID"];
    return array;
}
//get array with confs Names
//use dictionary from getConfs
-(NSArray *)getConfsNameFromServer:(NSDictionary *)confsRaw{
    NSArray *array=[confsRaw valueForKey:@"Name"];
    return array;
}
//get image corresponding to confID
//use singular ID from getConfsID
-(UIImage *)getConfImageFromServer:(NSString *)confID{
    NSString* imgPath=[NSString stringWithFormat:@"%@%@%@",@"http://193.136.122.141/",confID,@"/confLogo.jpg"];
    NSURL* imgURL=[NSURL URLWithString:imgPath];
    
    NSData* imgData=[NSData dataWithContentsOfURL:imgURL options:kNilOptions error:NULL];
    UIImage* img =[UIImage imageWithData:imgData];
    
    return img;
}

//returns dictionary in the form of {ID;ImagePath;Name}
//where ImagePath is not required for presentation
- (NSDictionary *)getConfsFromServer{ //return @"test";
    NSURL *url= [NSURL URLWithString:@"http://193.136.122.141/showConfs.php"];
    NSURLRequest *request= [NSURLRequest requestWithURL:url
                                            cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                        timeoutInterval:30];
    
    NSData *data;
    NSURLResponse *response;
   // NSError *error;
    
    data=[NSURLConnection sendSynchronousRequest: request returningResponse: &response error: NULL];
    
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
    
    //get all the values with key=ID
    //NSArray *array=[json valueForKey:@"ID"];
    //get specific index for the value with key=Name
    //NSArray *array1=[[json valueForKey:@"Name"] objectAtIndex:1];
    //log results
    //NSLog(@"All Info: %@", json);
    //NSLog(@"All IDs: %@", array);
    //NSLog(@"Name in position 1: %@", array1);
    //return [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
    return json;
    
    
}

-(BOOL)fetchConferences{
    NSDictionary* fetch = [self getConfsFromServer];
    if(fetch == NULL){
        return false;
    }
    else{
        NSArray* dataIDs = [self getConfsIDFromServer: fetch];
        NSArray* dataNames = [self getConfsNameFromServer: fetch];
        
        if(dataIDs == NULL || dataNames == NULL){
            return false;
        }
        
        //Tratar aqui das imagens
        UIImage* currentImg;
        //NSMutableArray* conferences = [[NSMutableArray alloc] init];;
        Conference* current;
        for (int i=0; i < [dataIDs count]; i++) {
            current = [Conference new];
            current = [current initWithData: dataIDs[i] name: dataNames[i] image: NULL /*alterar depois*/ bluePrint: NULL];
            if ([self addToAllConference: current] == true){
                currentImg = [self getConfImageFromServer:dataIDs[i]];
                if(currentImg == NULL){
                    return false;
                }
                [((Conference*)[allConferences lastObject]) changeLogo: currentImg];
            }
        }
        return true;
    }
    
}

-(NSArray*)getRestOfConfs{
    NSMutableArray* ret;
    for (int i=0; i<[allConferences count]; i++) {
        if([conferences indexOfObject:[allConferences objectAtIndex:i]] == NSNotFound){
            [ret addObject: [allConferences objectAtIndex:i]];
        }
    }
    return ret;
    
}

-(NSString*)getfetchedIDs{
    NSMutableString* ret;
    //ret = @"IDs: ";
    [ret  appendString: @"IDs: "];
    NSDictionary* fetch = [self getConfsFromServer];
    NSArray* dataIDs = [self getConfsIDFromServer: fetch];
    NSString* tmp=@"";
    for(int i=0; i<[dataIDs count]; i++){
        tmp= [NSString stringWithFormat:@"%@%@%@",tmp, @", ",[dataIDs objectAtIndex:i]];
    }
    
    return tmp;
}

@end