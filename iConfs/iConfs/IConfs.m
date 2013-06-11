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
    conferencesDic = [[NSMutableDictionary alloc] init];
    allConferencesDic = [[NSMutableDictionary alloc] init];
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



-(BOOL)addConferenceWithID:(NSString*)confID{
    BOOL isHere = false;
    for (int i=0; i<[conferences count]; i++) {
        if ([((Conference*)[conferences objectAtIndex:i]).getID isEqualToString: confID]){
            isHere = true;
            break;
        }
    }
    if(isHere == false){
        [self addConf: confID];
        [conferences addObject: [self jsonToConference:confID]];
        return true;
    }
    else return false;
}

-(BOOL)addConference:(Conference*)c{
    /*BOOL isHere = false;
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
    else return false;*/
    if ([self addConferenceWithID: [c getID]]) {
        return true;
    }else{
        return false;
    }
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
        [self deleteConfFromDrive:confID];
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
            [allConferencesDic setObject:[allConferences lastObject]  forKey: ((Conference*)[allConferences lastObject]).getID];
        }
        //NSLog(@"DataIDs: %@", allConferences);
        return true;
    }
    
}

-(BOOL)fetchConferencesFull{
    //NSDictionary* fetch = [self getConfsFromServer];
    return false;
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
            [self deleteConfFromDrive:confID];
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


-(Conference*)jsonToConference:(NSString*)confID{
    Conference* conf;
    conf = [[Conference alloc] init];
    //conf = [allConferencesDic valueForKey:confID];
    
    
    NSDictionary* raw;
    NSMutableDictionary* speakers;
    NSMutableDictionary* authors;
    NSMutableDictionary* organizers;
    NSMutableArray* sessions;
    NSMutableArray* workshops;
    NSMutableArray* otherEvents;
    NSMutableArray* notifications;
    NSMutableDictionary* papers;
    
    speakers = [[NSMutableDictionary alloc] init];
    authors = [[NSMutableDictionary alloc] init];
    organizers = [[NSMutableDictionary alloc] init];
    //sessions = [[NSMutableArray alloc] init];
    //workshops = [[NSMutableArray alloc] init];
    //otherEvents = [[NSMutableArray alloc] init];
    //notifications = [[NSMutableArray alloc] init];
    papers = [[NSMutableDictionary alloc] init];
    
    NSString *parsedID, *parsedIDAUX;
    Speaker *speakerAux;
    Author *authorAux;
    Organizer *organizerAux;
    int currID, currIDAUX;
    raw = [self parseJSON: [self loadDataFromDrive: confID]];
    //NSLog(@"json:%@",raw);
    //[[json objectForKey:@"conf"] objectAtIndex:0]valueForKey:@"ID";
    
    //loadImageFromDrive:(NSString*)confID : (NSString*)imagePath
    UIImage* confIm = [self loadImageFromDrive: confID : [conf valueForKey:@"ImagePath"] ];
    
    
    NSDictionary* c = [raw valueForKey:@"conf"];
    conf = [conf initWithData: [conf valueForKey:@"ID"] name: [conf valueForKey:@"Name"] image:confIm bluePrint:NULL /*precisa de ser implementado no servidor*/];
    
    NSArray* notif = [raw valueForKey:@"notif"];
    Notification* n;
    for (int i = 0; i<[notif count]; i++) {
        n = [[Notification alloc] init];
        
        n = [n initWithData: [notif[i] valueForKey:@"Title"] text: [notif[i] valueForKey:@"Description"] date: (NSDate*)[notif[i] valueForKey:@"TimeStamp"]];
        //[notifications addObject: n];
        [conf addNotification:n];
    }

    //People
    NSArray* people = [raw valueForKey:@"person"];
    Person* p;
    for (int i = 0; 0<[people count]; i++) {
        currID = [[[[people[i] valueForKey:@"ID"]componentsSeparatedByString:@"s"] objectAtIndex: 1]intValue];
        if ([[people[i] valueForKey:@"Type"] isEqual:@"Author"]){
            p = [[Author alloc] init];
            p = [(Author*)p initWithData: [people[i] valueForKey:@"Name"] work: [people[i] valueForKey:@"Company"] /*queremos o cargo e não a companhia*/ image:[people[i] valueForKey:@"ImagePath"] personID: currID];
            [authors setValue:p forKey:[[[people[i] valueForKey:@"ID"]componentsSeparatedByString:@"p"] objectAtIndex: 1]];
            [conf addAuthor:(Author*)p];
        }
        else if ([[people[i] valueForKey:@"Type"] isEqual:@"Speaker"]){
            p = [[Speaker alloc] init];
            p = [(Speaker*)p initWithData: [people[i] valueForKey:@"Name"] work: [people[i] valueForKey:@"Company"] image:[people[i] valueForKey:@"ImagePath"] personID: currID resume: [people[i] valueForKey:@"Description"]];
            [speakers setValue:p forKey:[[[people[i] valueForKey:@"ID"]componentsSeparatedByString:@"p"] objectAtIndex: 1]];
            [conf addSpeaker:(Speaker*)p];
        }
        else if ([[people[i] valueForKey:@"Type"] isEqual:@"Organizer"]){
            p = [[Organizer alloc] init];
            p = [(Organizer*)p initWithData: [people[i] valueForKey:@"Name"] work: [people[i] valueForKey:@"Company"] image:[people[i] valueForKey:@"ImagePath"] personID: currID job: [people[i] valueForKey:@"Description"]];
            [organizers setValue:p forKey:[[[people[i] valueForKey:@"ID"]componentsSeparatedByString:@"p"] objectAtIndex: 1]];
            [conf addOrganizer:(Organizer*)p];
        } //Isto precisava de ser um ISA no MySQL do servidor...
    }
    
    NSArray * au = [authors allValues];
    NSArray * sp = [speakers allValues];
    NSArray * or = [organizers allValues];
    for (int i = 0; i < [au count]; i++) {
        [conf addAuthor:au[i]];
    }
    for (int i = 0; i < [sp count]; i++) {
        [conf addSpeaker:sp[i]];
    }
    for (int i = 0; i < [or count]; i++) {
        [conf addOrganizer:or[i]];
    }
    
    //Events
    NSArray* sess = [raw valueForKey:@"session"];
    Event* e;
    for (int i = 0; i<[sess count]; i++) {
        if(![[sess[i] valueForKey:@"Speaker"] isEqual:@""]){
            parsedIDAUX = [[[sess[i] valueForKey:@"Speaker"]componentsSeparatedByString:@"p"] objectAtIndex: 1];
            speakerAux = [speakers objectForKey:parsedIDAUX];
        }else{
            speakerAux = NULL;
        }
        if(![[sess[i] valueForKey:@"Author"] isEqual:@""]){
            parsedIDAUX = [[[sess[i] valueForKey:@"Author"]componentsSeparatedByString:@"p"] objectAtIndex: 1];
            authorAux = [speakers objectForKey:parsedIDAUX];
        }else{
            authorAux = NULL;
        }
        currID = [[[[sess[i] valueForKey:@"ID"]componentsSeparatedByString:@"s"] objectAtIndex: 1]intValue];
        if ([[sess[i] valueForKey:@"Type"] isEqual:@"Session"]) {
            e = [[Session alloc] init];
            e = [(Session*)e initWithDataAndSpeaker:currID date:[sess[i] valueForKey:@"DateTime"] title:[sess[i] valueForKey:@"Name"] theme:[sess[i] valueForKey:@"Description"] speaker: speakerAux athor: authorAux];
            //[sessions addObject:e];
            [conf addSessions:(Session*)e];
        }
        else if ([[sess[i] valueForKey:@"Type"] isEqual:@"Workshop"]){
            e = [[EventWorkshop alloc] init];
            e = [(EventWorkshop*)e initWithDataAndSpeaker:currID date:[sess[i] valueForKey:@"DateTime"] title:[sess[i] valueForKey:@"Name"] theme:[sess[i] valueForKey:@"Description"] speaker: speakerAux needs: [sess[i] valueForKey:@"Needs"]];
            //[workshops addObject:e];
            [conf addWorkshop:(EventWorkshop*)e];
        }
        else{
            e = [[EventWorkshop alloc] init];
            e = [(Event*)e initWithData:currID date:[sess[i] valueForKey:@"DateTime"] title:[sess[i] valueForKey:@"Name"] theme:[sess[i] valueForKey:@"Description"]];
            //[otherEvents addObject: e];
            [conf addOtherEvent:e];
        }
        [e setRating:[[sess[i] valueForKey:@"Rating"] intValue]];
    }
    
    return conf;
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
-(BOOL)deleteConfFromDrive:(NSString*)confID{
    
    NSString* savePath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@".json"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    return [fileManager removeItemAtPath:savePath error:NULL];
}

//loads nsdata from file with name confID (.json) in documents
-(NSData*)loadDataFromDrive:(NSString*)confID{
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

//Saves NSArray with confIDs to file
-(BOOL)saveConfsIDs:(NSArray*)confIDs{
    NSString* savePath=[NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/confs.json"];
    
    return[confIDs writeToFile:savePath atomically:YES];
}


//getRating given confID and sessionID
//returns -1 if cannot fetch
-(double)getRating:(NSString*)confID : (NSString*)sessionID{
    
    NSString* post=[NSString stringWithFormat:@"%@%@%@%@%@",@"Conf=",confID,@"&&Session=",sessionID,@"&SubmitCheck=Sent"];
    NSData* postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString* postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://193.136.122.141/ratingGet.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLResponse* response;
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    if(data!=NULL){
        NSDictionary*json=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
        
        double trouble= [[[json valueForKey:@"Rating"] objectAtIndex:0] doubleValue];
        // NSLog(@"rating:%f",trouble);
        return trouble;
    }else return -1;
    
}

//getRating given confID and sessionID
//returns true if rating sent else false
-(BOOL)setRating:(NSString*)confID : (NSString*)sessionID : (NSInteger)rating{
    
    NSString* post=[NSString stringWithFormat:@"%@%@%@%@%@%ld%@",@"Conf=",confID,@"&&Session=",sessionID,@"&&Rating=",(long)rating,@"&SubmitCheck=Sent"];
    NSData* postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString* postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://193.136.122.141/ratingSet.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLResponse* response;
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    if(data!=NULL){
        return YES;
    }else return NO;
}

//getNotifs in NSDictionary for confID where notifDate > timeStamp
//timeStamp will only count the first 10 digits ex.:1356998400
//may return empty dictionary if none found
//returns null if cannot fetch
//NOTA IMPORTANTE QUE NAO POSSO PARAR DE REFERIR
//CUIDADO COM AS HORAS EM CONCRETO VISTO O SERVIDOR FUNCIONAR COM AS HORAS PORTUGUESAS
//O QUE IMPLICA QUE TEM DAYLIGHT SAVINGS LIGADO DE MOMENTO, LOGO TEEM DE TIRAR 1 (UMA)
//HORA AOS TIMESTAMP QUE ENVIAREM, OU SEJA VALOR-3600
//ALSO, NAO SE ESQUECAM QUE O PEDIDO EH PARA VALORES MAIORES QUE X, NAO MAIORES OU IGUAIS
-(NSDictionary*)getNotifs:(NSString*)confID : (long)timeStamp{
    //NSLog(@"test:%ld",timeStamp);
    NSString* post=[NSString stringWithFormat:@"%@%@%@%ld%@",@"Conf=",confID,@"&&TS=",timeStamp,@"&SubmitCheck=Sent"];
    NSData* postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString* postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://193.136.122.141/notifGet.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    
    NSURLResponse* response;
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    
    if(data!=NULL){
        NSDictionary*json=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];
        // NSLog(@"testNotifs:%@",json);
        return json;
    }else return NULL;
    
}

//dado o confID e a variavel imagePath (ex.: @"confImage.jpg") devolve a imagem respectiva
// ou null caso nao a consiga encontrar/aceder
-(UIImage*)loadImageFromDrive:(NSString*)confID : (NSString*)imagePath{
    
    NSString* imgPath=[NSString stringWithFormat:@"%@%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/",imagePath];
    
    NSData* imgData=[NSData dataWithContentsOfFile:imgPath options:kNilOptions error:NULL];
    UIImage* img;
    if (imgData == NULL)
        img = NULL;
    else
        img =[UIImage imageWithData:imgData];
    
    return img;
    
    
}

@end