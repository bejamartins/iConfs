//
//  IConfs.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "IConfs.h"
#import "ZipArchive.h"

@implementation IConfs


-(IConfs*)initiConfs: (NSArray*)aConferences{
    //allConferences = [aConferences copy];
    //allConferences = [NSMutableArray new];
    allConferences = [[NSMutableArray alloc] init];
    if(aConferences != NULL){
        allConferences = [aConferences copy];
    }
    conferences = [NSMutableArray new];
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
        if ([((Conference*)[conferences objectAtIndex:i]).getID isEqualToString: c.getID]){
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
        if ([((Conference*)[allConferences objectAtIndex:i]).getID isEqualToString: c.getID]){
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


-(BOOL)removeConference:(NSString*)confID{
    BOOL isHere = false;
    //NSObject toRemove;
    int index;
    for (int i=0; i<[conferences count]; i++) {
        if ([((Conference*)[conferences objectAtIndex:i]).getID isEqualToString: confID]){
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
        NSLog(@"DataIDs: %@", allConferences);
        return true;
    }
    
}

-(NSArray*)getRestOfConfs{
    NSMutableArray* ret;
    ret = [NSMutableArray new];
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
    NSLog(@"DataIDs: %@", dataIDs);
    for(int i=0; i<[dataIDs count]; i++){
        tmp= [NSString stringWithFormat:@"%@%@%@",tmp, @", ",[dataIDs objectAtIndex:i]];
    }
    
    return tmp;
}


//////////////////////////////////
//////////////////////////////////
//////////////////////////////////
//////////////////////////////////

/*
 getConfFiles part
 */

//gets the conf batch from the server and saves them to disk
//also removes artifacts in case of error
//uses the 3 functions below: getConf, getConfFiles and saveConf
-(BOOL)addConf:(NSString*)confID{
    
    NSData* tmpData=[self getConf:confID];
    if(tmpData!=NULL){
        NSDictionary* tmpConf=[self parseJSON:tmpData];
        [self saveConf:tmpConf:tmpData];
        if([self getConfFiles:confID]==false){
            [self deleteConf:confID];
            return false;
        }
    }else return false;
    return true;
}

//recebe toda a info relativa a uma conferencia cujo ID eh
//confID. Usado para fazer o "download" da conferencia no
//manage conferences, pode ser usado tambem para guardar updates
//de notificacoes e ratings
- (NSData*)getConf:(NSString*)confID{
    NSString* post=[NSString stringWithFormat:@"%@%@%@",@"Conf=",confID,@"&SubmitCheck=Sent"];
    
    //NSLog(@"post is: %@", post);
    
    NSData* postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString* postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://193.136.122.141/confGet.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // NSURLConnection* conn=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    // NSData* data =[[conn] sendSy
    NSURLResponse* response;
    return[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    // NSLog(@"test:%@",conn);
    // NSData* data= conn;
    // NSDictionary* json;
    // NSLog(@"test:%@",data);
    //  NSLog(@"Json:%@", json);
    //  NSString* test=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //  NSLog(@"String:%@",test);
    
}

//used to created the NSDictionary with the JSON, receives NSData
-(NSDictionary*) parseJSON:(NSData*)confData{
    return [NSJSONSerialization JSONObjectWithData:confData options:kNilOptions error:NULL];
}

//saves conference files (zip) from server to folder confID inside documents
//receives confID
- (BOOL)getConfFiles:(NSString*)confID{
    NSString* post=[NSString stringWithFormat:@"%@%@%@",@"Conf=",confID,@"&SubmitCheck=Sent"];
    
    //NSLog(@"post is: %@", post);
    
    NSData* postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString* postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://193.136.122.141/filesGet.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLResponse* response;
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    //NSLog(@"Data is: %@",data);
    if (data!=NULL){
        NSString* savePath=[NSString stringWithFormat:@"%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID];
        
        NSString* saveZip=[NSString stringWithFormat:@"%@%@",savePath,@".zip"];
        //guarda zip
        [data writeToFile:saveZip atomically:YES];
        
        //faz unzip
        ZipArchive* zipArchive=[[ZipArchive alloc]init];
        [zipArchive UnzipOpenFile:saveZip];
        [zipArchive UnzipFileTo:savePath overWrite:YES];
        [zipArchive UnzipCloseFile];
        //[zipArchive release];
        //elimina zip
        NSFileManager* fileManager=[NSFileManager defaultManager];
        [fileManager removeItemAtPath:saveZip error:NULL];
        
        return true;
    }else return false;
    
}

//saves conf from NSDictionary to the documents folder with name confID.json
-(BOOL)saveConf:(NSDictionary*)conf : (NSData*)confData{
    //NSLog(@"conf:%@",conf);
    NSString* savePath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",[[[conf objectForKey:@"conf"]valueForKey:@"ID"]objectAtIndex:0],@".json"];
    //guarda conf
    [confData writeToFile:savePath atomically:YES];
    
    return true;
    
}

//deletes confID.json and confID folder
-(BOOL)deleteConf:(NSString*)confID{
    
    NSString* savePath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@".json"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    return [fileManager removeItemAtPath:savePath error:NULL];
}

//loads nsdata from file with name confID (.json) in documents
-(NSData*)loadData:(NSString*)confID{
    NSString* loadPath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@".json"];
    return [NSData dataWithContentsOfFile:loadPath options:kNilOptions error:NULL];
    
}


//loads file from app with confIDs NSArray
//creates NSData new file if none found
-(NSArray*)loadConfsIDs{
    NSString* loadPath=[NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/confs.json"];
    NSData* tmpData =[NSData dataWithContentsOfFile:loadPath options:kNilOptions error:NULL];
    
    if(tmpData==NULL){//no file or could not retrieve then create new one
        [[NSData new] writeToFile:loadPath atomically:YES];
        return NULL;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:tmpData];
}

@end