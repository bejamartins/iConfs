//
//  IConfs.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//


/*
 NOTA GRANDE E IMPORTANTE, UNICAS FUN«OES QUE DEVEM SER USADAS SAO:
 loadImage:confID:imgPath
 getNotifs:confID:timeStamp
 setRating:confID:sessionID:rating
 getRating:confID:sessionID
 loadConfsIDs
 A FUNCAO QUE O EDDY E EU ESTAMOS A MEIO theAlmightyGetter:confID (que usa parseJSON:[loadData:confID])
 deleteConf:confID
 addConf:confID
 
 COMO EXTRA HA AINDA A CONCATENACAO DE FUNCOES SEGUINTE PARA FAZER UM GENERO DE "UPDATE" A UMA CONF
 NSDATA*tmp=getConf:confID
 saveConf:[parseJSON:tmp]:tmp
 QUE PODE SER USADA POR EXEMPLO PARA UM UPDATE TOTAL DE NOTIFICACOES E DE RATINGS
 LUGARES PROPOSTOS PARA UTILIZACAO: ENTRAR NA CONF, SAIR DA CONF, INICIAR A APLICACAO, SAIR DA APLICACAO
 VER RATING, MANDAR RATING E/OU VER NOTIFS
 */



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
    addedConfsIDs = [[NSMutableArray alloc] init];
    agenda = [[NSMutableArray alloc] init];
    agendaDic = [[NSMutableDictionary alloc] init];
    agendaStartDate = [[NSDate alloc] init];
    return self;
}

/*-(BOOL)addEventToAgenda:(Event*)event{
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
}*/


-(BOOL)subscribeSuperSessionInAgenda: (SuperSession*)ss{
    if([agendaDic objectForKey:[ss getID]] != nil){
        return false;
    }
    else{
        CustomizableSuperSession* css;
        css = [[CustomizableSuperSession alloc]init];
        css = [css initWithSuperSession:ss];
        [agenda addObject: css];
        [agendaDic setObject:css forKey:[css getID]];
        [agenda sortUsingSelector:@selector(compare:)];
        agendaStartDate = [((CustomizableSuperSession*)[agenda objectAtIndex:0]) getUserStartDate];
        return true;
    }
}

-(NSArray*)getAgendaOrderedByDate{
    return agenda;
}

-(NSDictionary*)getAgendaDicionary{
    return agendaDic;
}

-(BOOL)unsubscribeSuperSessionInAgenda:(NSString*)superSessionID{
    if([agendaDic objectForKey: superSessionID] == nil){
        return false;
    }
    else{
        CustomizableSuperSession* s = [agendaDic objectForKey:superSessionID];
        [agenda removeObject: s];
        [agendaDic removeObjectForKey:superSessionID];
        [agenda sortUsingSelector:@selector(compare:)];
        if([agenda count] != 0){
            agendaStartDate = [((CustomizableSuperSession*)[agenda objectAtIndex:0]) getUserStartDate];
        }
        else{
            agendaStartDate = nil;
        }
        return true;
    }
}

-(NSDate*)getAgendaStartDate{
    return agendaStartDate;
}

-(NSArray*)getAvailableSuperSessions{
    NSMutableArray* ret;
    for (int i=0; i<[conferences count]; i++) {
        [ret addObjectsFromArray:[[((Conference*)conferences[i]) getSuperSessions] allValues]];
    }
    return ret;
}

-(NSArray*)getUnsubscribedSuperSessions{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    NSString* a;
    NSArray* availableSS = [self getAvailableSuperSessions];
    for (int i=0; i<[availableSS count]; i++) {
        a = [(SuperSession*)[availableSS objectAtIndex:i] getID];
        if([agendaDic objectForKey:a] == nil){
            [ret addObject: [availableSS objectAtIndex:i]];
        }
    }
    return ret;
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
        [addedConfsIDs addObject:confID];
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
        //NSNumber* ref = [NSNumber numberWithInt:[addedConfsIDs indexOfObject:confID]];
        [addedConfsIDs removeObjectAtIndex:[addedConfsIDs indexOfObject:confID]];
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
        return true;
    }
    
}

-(BOOL)fetchConferencesFull{
    //NSDictionary* fetch = [self getConfsFromServer];
    return false;
}

-(NSArray*)getRestOfConfs{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
    NSString* a;
    for (int i=0; i<[allConferences count]; i++) {
        //if([conferences indexOfObject:[allConferences objectAtIndex:i]] == NSNotFound){
        a = [(Conference*)[allConferences objectAtIndex:i] getID];
        if([addedConfsIDs indexOfObject:a] == NSNotFound){
            //if([[addedConfsIDs indexOfObject:[((Conferece*)[allConferences objectAtIndex:i]) getID]] isEqual NSNotFound]){
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
//now also adds to the confs.json file
-(BOOL)addConf:(NSString*)confID{
    
    NSData* tmpData=[self getConf:confID];
    if(tmpData!=NULL){
        NSDictionary* tmpConf=[self parseJSON:tmpData];
        [self saveConf:tmpConf:tmpData];
        if([self getConfFiles:confID]==NO){
            [self deleteConfFromDrive:confID];
            return NO;
        }
    }else return NO;
    
    if([self saveConfsIDs:[self addConfsIDs:[self loadConfsIDs] : confID]])
        return YES;
    else {
        [self deleteConfFromDrive:confID];
        return NO;
    }
}


//recebe toda a info relativa a uma conferencia cujo ID eh
//confID. Usado para fazer o "download" da conferencia no
//manage conferences, pode ser usado tambem para guardar updates
//de notificacoes e ratings
- (NSData*)getConf:(NSString*)confID{
    NSString* post=[NSString stringWithFormat:@"%@%@%@",@"Conf=",confID,@"&SubmitCheck=Sent"];
    
    
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
    
    // NSData* data= conn;
    // NSDictionary* json;
    //  NSString* test=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
}

-(void)bootableConfs{
    
    NSArray*tmpConfs=[self loadConfsIDs];
    Conference* current;
    for (int i=0; i<[tmpConfs count]; i++) {
        current = [self jsonToConference:[tmpConfs objectAtIndex:i]];
        [conferences addObject:current];
        [addedConfsIDs addObject:[current getID]];
        
        //agenda here, not totally TODO: this load agenda must pass the NSDictionary to a variable
        [self loadAgenda:[tmpConfs objectAtIndex:i]];
    }
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
    NSMutableDictionary* supersessions;
    
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
    //[[json objectForKey:@"conf"] objectAtIndex:0]valueForKey:@"ID";
    
    //loadImageFromDrive:(NSString*)confID : (NSString*)imagePath
    
    //Papers
    //IDPerson
    NSArray* papersR = [raw valueForKey:@"paper"];
    Paper* pp;
    NSMutableArray* auth;
    NSMutableArray* papersList;
    NSMutableDictionary* papersByID = [[NSMutableDictionary alloc]init];
    for(int i = 0; i<[papersR count]; i++){
        pp = [[Paper alloc] init];
        auth = [[NSMutableArray alloc] init];
        [auth addObject:[papersR[i] valueForKey:@"IDPerson"]];
        pp = [pp initWithData: [[[[papersR[i] valueForKey:@"ID"]componentsSeparatedByString:@"p"] objectAtIndex: 1]intValue] title:NULL /*falta titulo*/ authors: auth abstract:NULL link:[papersR[i] valueForKey:@"PaperPath"]];
        [pp setSession:[papersR[i] valueForKey:@"IDSession"]];
        [papersByID setObject:pp forKey:[papersR[i] valueForKey:@"ID"]];
        if ([papers valueForKey:[papersR[i] valueForKey:@"IDPerson"]] == nil) {
            papersList = [[NSMutableArray alloc] init];
            [papersList addObject: pp];
            [papers setObject:papersList forKey:[((NSDictionary*)papersR[i]) valueForKey:@"IDPerson"]];
        }
        else{
            [[papers objectForKey:[((NSDictionary*)papersR[i]) valueForKey:@"IDPerson"]] addObject: pp];
            
            //[[papers objectForKey:[papersR[i] valueForKey:@"IDPerson"]] addObject: papersR[i]];
        }
    }
    
    //more people to papers
    NSArray* paperPeople = [raw objectForKey:@"paperPeople"];
    for (int i =0; i<[paperPeople count]; i++) {
        [((Paper*)[papersByID valueForKey:[paperPeople[i] valueForKey:@"IDPaper"]]) addAuthor:[paperPeople[i] valueForKey:@"IDPerson"]];
        
        if ([papers valueForKey:[paperPeople[i] valueForKey:@"IDPerson"]] == nil) {
            papersList = [[NSMutableArray alloc] init];
            [papersList addObject: [papersByID valueForKey:[paperPeople[i] valueForKey:@"IDPaper"]]];
            [papers setObject:papersList forKey:[paperPeople[i] valueForKey:@"IDPerson"]];
        }
        else{
            [[papers objectForKey:[paperPeople[i] valueForKey:@"IDPerson"]] addObject: [papersByID valueForKey:[paperPeople[i] valueForKey:@"IDPaper"]]];
            
            //[[papers objectForKey:[papersR[i] valueForKey:@"IDPerson"]] addObject: papersR[i]];
        }
    }
    
    //[paperID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"ID"]];
    //[paperConfID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"IDConf"]];
    //[paperSessionID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"IDSession"]];
    //[peperPersonID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"IDPerson"]];
    //[paperPath addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"PaperPath"]];
    
    //SuperSessions
    NSDictionary* ss = [raw valueForKey:@"superSession"];
    supersessions = [[NSMutableDictionary alloc]init];
    SuperSession* supers;
    for(int i = 0; i<[ss count]; i++){
        supers = [[SuperSession alloc]init];
    //    supers =[supers initWithData:[ss objectForKey:@"ID"] theme:NULL /*TODO on server*/];
   //     [supersessions setObject:supers forKey:[ss objectForKey:@"ID"]];
    }

    
    
    
    //Blueprints
    
    //plant
    
    NSArray* bp = [raw valueForKey:@"plant"];
    Blueprints* bluePrint = [[Blueprints alloc] init];
    NSMutableDictionary* blueprints = [[NSMutableDictionary alloc] init];
    NSMutableArray* places = [[NSMutableArray alloc] init];
    NSMutableArray* wcs = [[NSMutableArray alloc] init];
    NSMutableArray* eatingAreas = [[NSMutableArray alloc] init];
    NSMutableArray* rooms = [[NSMutableArray alloc] init];
    NSMutableArray* otherPlaces = [[NSMutableArray alloc] init];
    Place* currPlace;
    NSString* placeType;
    Room* room;
    WC* wc;
    EatingArea* ea;
    NSMutableDictionary* places1;
    places1 = [[NSMutableDictionary alloc] init];
    NSMutableArray* placesList;
    NSArray* plp = [raw valueForKey:@"plantPlots"];
    
    for (int i = 0; i<[plp count]; i++) {
        if ([places1 valueForKey:[(NSDictionary*)plp[i] valueForKey:@"IDPlant"]] == nil) {
            placesList = [[NSMutableArray alloc] init];
            [placesList addObject: plp[i]];
            [places1 setObject:placesList forKey:[((NSDictionary*)plp[i]) valueForKey:@"IDPlant"]];
        }
        else{
            [[places1 objectForKey:[((NSDictionary*)plp[i]) valueForKey:@"IDPlant"]] addObject: plp[i]];
        }
    }
    for (int i=0; i<[bp count]; i++) {
        bluePrint = [[Blueprints alloc] init];
        places = [[NSMutableArray alloc] init];
        //places = [bp[i] valueForKey:@"plantPlots"];
        places = [places1 valueForKey:[[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ID"]];
        wcs = [[NSMutableArray alloc] init];
        eatingAreas = [[NSMutableArray alloc] init];
        rooms = [[NSMutableArray alloc] init];
        otherPlaces = [[NSMutableArray alloc] init];
        for (int j = 0; j < [places count]; j++) {
            placeType = [[NSString alloc] init];
            placeType = [places[j] valueForKey:@"Type"];
            if ([placeType isEqualToString:@"RM"]) {
                room = [[Room alloc] init];
                room = [room initRoom: [places[j] valueForKey:@"ID"] x:[[places[j] valueForKey:@"xPos"]intValue] y:[[places[j] valueForKey:@"yPos"]intValue] name:[places[j] valueForKey:@"Name"]];
                [rooms addObject:room];
            }
            else if([placeType isEqualToString:@"EA"]){
                ea = [[EatingArea alloc] init];
                ea = [ea initEA: [places[j] valueForKey:@"ID"] x:[[places[j] valueForKey:@"xPos"]intValue] y:[[places[j] valueForKey:@"yPos"]intValue] name:[places[j] valueForKey:@"Name"]];
                [eatingAreas addObject:ea];
            }
            else if([placeType isEqualToString:@"WC"]){
                wc = [[WC alloc] init];
                wc = [wc initPlace: [places[j] valueForKey:@"ID"] x:[[places[j] valueForKey:@"xPos"]intValue] y:[[places[j] valueForKey:@"yPos"]intValue]];
                [wcs addObject:wc];
            }
            else{
                currPlace = [[Place alloc] init];
                currPlace = [currPlace initPlace: [places[j] valueForKey:@"ID"] name:[places[j] valueForKey:@"ID"] x:[[places[j] valueForKey:@"xPos"]intValue] y:[[places[j] valueForKey:@"yPos"]intValue]];
                //[currPlace alterLogo:<#(NSString *)#>];
                [otherPlaces addObject:currPlace];
            }
            
        }
        
        [[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ID"];
        [[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"Name"];
        [[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ImagePath"];
        //[places eatingAreas: eatingAreas WCs: wcs rooms: rooms];
        bluePrint = [bluePrint initWithData: [[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ID"] title: [[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"Name"] imagePath:[[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ImagePath"] otherPlaces: otherPlaces eatingAreas: eatingAreas WCs: wcs rooms: rooms];
        [blueprints setObject:bluePrint forKey:[[[raw valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ID"] ];
        
    }
    
    NSDictionary* c = [[raw valueForKey:@"conf"]objectAtIndex:0];
    UIImage* confIm = [self loadImageFromDrive: confID : [c valueForKey:@"ImagePath"] ];
    conf = [conf initWithData: [c valueForKey:@"ID"] name: [c valueForKey:@"Name"] image:confIm bluePrint:blueprints];
    
    // NSString* confName=[[[json valueForKey:@"conf"] objectAtIndex:0] valueForKey:@"Name"];
    
    
    NSArray* notif = [[NSArray alloc] init];
    NSArray* news = [[NSArray alloc] init];
    notif = [raw valueForKey:@"notif"];
    Notification* n;
    News* nw;
    for (int i = 0; i<[notif count]; i++) {
        n = [[Notification alloc] init];
        nw = [[News alloc] init];
        if([[notif[i] valueForKey:@"Highlight"] isEqualToString: @"0"]){
            n = [n initWithData: [notif[i] valueForKey:@"ID"] title:[notif[i] valueForKey:@"Title"] text: [notif[i] valueForKey:@"Description"] date: (NSDate*)[notif[i] valueForKey:@"TimeStamp"]];
            //[notifications addObject: n];
            [conf addNotification:n];
        }
        else{
            nw = [nw initWithData: [notif[i] valueForKey:@"ID"] title:[notif[i] valueForKey:@"Title"] text: [notif[i] valueForKey:@"Description"] date:(NSDate*)[notif[i] valueForKey:@"TimeStamp"]];
            [conf addNews:nw];
        }
        
    }
    
    //People
    NSArray* people = [[NSArray alloc]  init];
    people = [raw valueForKey:@"person"];
    Person* p;
    for (int i = 0; i<[people count]; i++) {
        currID = [[[[people[i] valueForKey:@"ID"]componentsSeparatedByString:@"p"] objectAtIndex: 1]intValue];
        if ([[people[i] valueForKey:@"Type"] isEqual:@"Author"]){
            p = [[Author alloc] init];
            p = [(Author*)p initWithData: [people[i] valueForKey:@"Name"] work: [people[i] valueForKey:@"Company"] /*queremos o cargo e não a companhia*/ image:[people[i] valueForKey:@"ImagePath"] personID: currID];
            [authors setObject:p forKey:[NSString stringWithFormat:@"%d",currID]];
            [conf addAuthor:(Author*)p];
            if([[papers allKeys] containsObject:[people[i] valueForKey:@"ID"]]){
                for (int j = 0; j<[((NSArray*)[papers valueForKey:[people[i] valueForKey:@"ID"]]) count]; j++) {
                    [((Author*)p) addPapper:(((NSArray*)[papers valueForKey:[people[i] valueForKey:@"ID"]])[j])];
                }
            }
        }
        else if ([[people[i] valueForKey:@"Type"] isEqual:@"Speaker"]){
            p = [[Speaker alloc] init];
            p = [(Speaker*)p initWithData: [people[i] valueForKey:@"Name"] work: [people[i] valueForKey:@"Company"] image:[people[i] valueForKey:@"ImagePath"] personID: currID resume: [people[i] valueForKey:@"Description"]];
            [speakers setObject:p forKey:[NSString stringWithFormat:@"%d",currID]];
            [conf addSpeaker:(Speaker*)p];
        }
        else if ([[people[i] valueForKey:@"Type"] isEqual:@"Organization"]){
            p = [[Organizer alloc] init];
            p = [(Organizer*)p initWithData: [people[i] valueForKey:@"Name"] work: [people[i] valueForKey:@"Company"] image:[people[i] valueForKey:@"ImagePath"] personID: currID job: [people[i] valueForKey:@"Description"]];
            [organizers setObject:p forKey:[NSString stringWithFormat:@"%d",currID]];
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
    NSArray* sess = [[NSArray alloc] init];
    sess = [raw valueForKey:@"session"];
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
            NSString* tmpS=((NSString*)[sess[i] valueForKey:@"PaperID"]);
            if(!([tmpS isEqual:@""])){
                currIDAUX = [[[tmpS componentsSeparatedByString:@"p"] objectAtIndex: 1] intValue];
            }else currIDAUX=-1;
            e = [(Session*)e initWithDataAndSpeaker:currID date:[sess[i] valueForKey:@"DateTime"] title:[sess[i] valueForKey:@"Name"] theme:[sess[i] valueForKey:@"Description"] speaker: speakerAux athor: authorAux paper:currIDAUX];
            //[sessions addObject:e];
            [conf addSessions:(Session*)e];
            [((SuperSession*)[supersessions valueForKey:[sess[i] valueForKey:@"IDSuperSession"]]) addSession:(Session*)e];
        }
        else if ([[sess[i] valueForKey:@"Type"] isEqual:@"Workshop"]){
            e = [[EventWorkshop alloc] init];
            e = [(EventWorkshop*)e initWithDataAndSpeaker:currID date:[sess[i] valueForKey:@"DateTime"] title:[sess[i] valueForKey:@"Name"] theme:[sess[i] valueForKey:@"Description"] speaker: speakerAux needs: [sess[i] valueForKey:@"Needs"]];
            //[workshops addObject:e];
            [conf addWorkshop:(EventWorkshop*)e];
            [((SuperSession*)[supersessions valueForKey:[sess[i] valueForKey:@"IDSuperSession"]]) addWorkshop:(EventWorkshop*)e];
        }
        else{
            e = [[EventWorkshop alloc] init];
            e = [(Event*)e initWithData:currID date:[sess[i] valueForKey:@"DateTime"] title:[sess[i] valueForKey:@"Name"] theme:[sess[i] valueForKey:@"Description"]];
            //[otherEvents addObject: e];
            [conf addOtherEvent:e];
            [((SuperSession*)[supersessions valueForKey:[sess[i] valueForKey:@"IDSuperSession"]]) addOtherEvent:e];
        }
        [e setRating:[[sess[i] valueForKey:@"Rating"] intValue]];
        [e addSuperSession: [sess[i] valueForKey:@"IDSuperSession"]];
    }
    NSDictionary* mapR = [[NSDictionary alloc]init];
    mapR =[raw valueForKey:@"Map"];
    Map* map = [[Map alloc]init];
    NSString* latitude = [mapR valueForKey:@"Latitude"];
    NSString* longitude = [mapR valueForKey:@"Longitude"];
    map = [map initWithData:[mapR valueForKey:@"ID"] lat:[latitude floatValue] longi:[longitude floatValue] placeName:[mapR valueForKey:@"PlaceName"] address:[mapR valueForKey:@"AddressName"]];
    [conf setMap:map];
    
    
    [conf setSuperSessions:supersessions];
    
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
        
        return YES;
    }else return NO;
    
}

//saves conf from NSDictionary to the documents folder with name confID.json
-(BOOL)saveConf:(NSDictionary*)conf : (NSData*)confData{
    NSString* savePath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",[[[conf objectForKey:@"conf"]valueForKey:@"ID"]objectAtIndex:0],@".json"];
    //guarda conf
    [confData writeToFile:savePath atomically:YES];
    
    return YES;
    
}

//deletes confID from confs.json; if it is successful also attempsts
//to remove confID.json and confID folder
-(BOOL)deleteConfFromDrive:(NSString*)confID{
    
    NSString* savePath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@".json"];
    NSString* savePath1=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/"];
    NSFileManager* fileManager=[NSFileManager defaultManager];
    
    if([self saveConfsIDs:[self removeConfsIDs:[self loadConfsIDs] : confID]])
        return [fileManager removeItemAtPath:savePath error:NULL] && [fileManager removeItemAtPath:savePath1 error:NULL];
    else return NO;
}

//loads nsdata from file with name confID (.json) in documents
-(NSData*)loadData:(NSString*)confID{
    NSString* loadPath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@".json"];
    return [NSData dataWithContentsOfFile:loadPath options:kNilOptions error:NULL];
    
}

//deletes confID.json and confID folder

//loads nsdata from file with name confID (.json) in documents
-(NSData*)loadDataFromDrive:(NSString*)confID{
    NSString* loadPath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@".json"];
    return [NSData dataWithContentsOfFile:loadPath options:kNilOptions error:NULL];
    
}


//loads file from app with confIDs NSArray
//creates NSArray new file if none found
-(NSArray*)loadConfsIDs{
    NSString* loadPath=[NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/confs.json"];
    //NSData* tmpData =[NSData dataWithContentsOfFile:loadPath options:kNilOptions error:NULL];
    NSArray* confs=[NSArray arrayWithContentsOfFile:loadPath];
    if(confs==nil){//no file or could not retrieve then create new one
        [[NSArray new] writeToFile:loadPath atomically:YES];
    }
    return confs;
}

//Saves NSArray with confIDs to file
-(BOOL)saveConfsIDs:(NSArray*)confIDs{
    NSString* savePath=[NSString stringWithFormat:@"%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/confs.json"];
    
    return[confIDs writeToFile:savePath atomically:YES];
}

//adds a confID to the confsIDs array if it is not already there
-(NSArray*)addConfsIDs:(NSArray*)confsIDs : (NSString*)confID{
    BOOL tmp = YES;
    NSMutableArray *tmp1= [NSMutableArray array];
    for (int i=0; i<[confsIDs count]; i++) {
        if ([confID isEqualToString:[confsIDs objectAtIndex:i]]) {
            tmp = NO;
        }
        [tmp1 addObject:[confsIDs objectAtIndex:i]];
    }
    
    if(tmp == YES){
        [tmp1 addObject:confID];
    }
    return tmp1;
}
//removes a confID from the confsIDs array if it is there
-(NSArray*)removeConfsIDs:(NSArray*)confsIDs : (NSString*)confID{
    BOOL tmp = YES;
    NSMutableArray *tmp1= [NSMutableArray array];
    for (int i=0; i<[confsIDs count]; i++) {
        if ([confID isEqualToString:[confsIDs objectAtIndex:i]]) {
            tmp = NO;
        }
        
        if(tmp == YES){
            [tmp1 addObject:[confsIDs objectAtIndex:i]];
        }
        tmp=YES;
    }
    return tmp1;
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

-(void)theAlmightyGetter:(NSDictionary*)json{
    
    //NSArray *array1=[[json valueForKey:@"Name"] objectAtIndex:1];
    
    //conf
    NSString* confConfID=[[[json valueForKey:@"conf"] objectAtIndex:0] valueForKey:@"ID"];
    NSString* confName=[[[json valueForKey:@"conf"] objectAtIndex:0] valueForKey:@"Name"];
    NSString* confImagePath=[[[json valueForKey:@"conf"] objectAtIndex:0] valueForKey:@"ImagePath"];
    //map
    NSString* mapConfID=[[[json valueForKey:@"map"] objectAtIndex:0] valueForKey:@"IDConf"];
    NSString* mapID=[[[json valueForKey:@"map"] objectAtIndex:0] valueForKey:@"ID"];
    NSString* mapPlaceName=[[[json valueForKey:@"map"] objectAtIndex:0] valueForKey:@"PlaceName"];
    NSString* mapAdressName=[[[json valueForKey:@"map"] objectAtIndex:0] valueForKey:@"AdressName"];
    NSString* mapLatitude=[[[json valueForKey:@"map"] objectAtIndex:0] valueForKey:@"Latitude"];
    NSString* mapLongitude=[[[json valueForKey:@"map"] objectAtIndex:0] valueForKey:@"Longitude"];
    //notif
    
    NSMutableArray* notifID=[NSMutableArray new];
    NSMutableArray* notifConfID=[NSMutableArray new];
    NSMutableArray* notifTitle=[NSMutableArray new];
    NSMutableArray* notifDescription=[NSMutableArray new];
    NSMutableArray* notifTimeStamp=[NSMutableArray new];
    NSMutableArray* notifHighlight=[NSMutableArray new];
    for (int i=0; i<[[json valueForKey:@"notif"]count]; i++) {
        
        [notifID addObject:[[[json valueForKey:@"notif"] objectAtIndex:i] valueForKey:@"ID"]];
        [notifConfID addObject:[[[json valueForKey:@"notif"] objectAtIndex:i] valueForKey:@"IDConf"]];
        [notifTitle addObject:[[[json valueForKey:@"notif"] objectAtIndex:i] valueForKey:@"Title"]];
        [notifDescription addObject:[[[json valueForKey:@"notif"] objectAtIndex:i] valueForKey:@"Description"]];
        [notifTimeStamp addObject:[[[json valueForKey:@"notif"] objectAtIndex:i] valueForKey:@"TimeStamp"]];
        [notifHighlight addObject:[[[json valueForKey:@"notif"] objectAtIndex:i] valueForKey:@"Highlight"]];
    }
    //paper
    
    NSMutableArray* paperID=[NSMutableArray new];
    NSMutableArray* paperConfID=[NSMutableArray new];
    NSMutableArray* paperSessionID=[NSMutableArray new];
    NSMutableArray* peperPersonID=[NSMutableArray new];
    NSMutableArray* paperPath=[NSMutableArray new];
    for (int i=0; i<[[json valueForKey:@"paper"]count]; i++) {
        
        [paperID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"ID"]];
        [paperConfID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"IDConf"]];
        [paperSessionID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"IDSession"]];
        [peperPersonID addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"IDPerson"]];
        [paperPath addObject:[[[json valueForKey:@"paper"] objectAtIndex:i] valueForKey:@"PaperPath"]];
    }
    
    //person
    
    NSMutableArray* personID=[NSMutableArray new];
    NSMutableArray* personConfID=[NSMutableArray new];
    NSMutableArray* personName=[NSMutableArray new];
    NSMutableArray* personType=[NSMutableArray new];
    NSMutableArray* personDescription=[NSMutableArray new];
    NSMutableArray* personImagePath=[NSMutableArray new];
    NSMutableArray* personCompany=[NSMutableArray new];
    for (int i=0; i<[[json valueForKey:@"person"]count]; i++) {
        
        [personID addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"ID"]];
        [personConfID addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"IDConf"]];
        [personName addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"Name"]];
        [personType addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"Type"]];
        [personDescription addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"Description"]];
        [personImagePath addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"ImagePath"]];
        [personCompany addObject:[[[json valueForKey:@"person"] objectAtIndex:i] valueForKey:@"Company"]];
    }
    
    //plant
    
    NSMutableArray* plantID=[NSMutableArray new];
    NSMutableArray* plantConfID=[NSMutableArray new];
    NSMutableArray* plantName=[NSMutableArray new];
    NSMutableArray* plantImagePath=[NSMutableArray new];
    for (int i=0; i<[[json valueForKey:@"plant"]count]; i++) {
        
        [plantID addObject:[[[json valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ID"]];
        [plantConfID addObject:[[[json valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"IDConf"]];
        [plantName addObject:[[[json valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"Name"]];
        [plantImagePath addObject:[[[json valueForKey:@"plant"] objectAtIndex:i] valueForKey:@"ImagePath"]];
        
    }
    
    //plantPlots
    
    NSMutableArray* plantPlotID=[NSMutableArray new];
    NSMutableArray* plantPlotConfID=[NSMutableArray new];
    NSMutableArray* plantPlotPlantID=[NSMutableArray new];
    NSMutableArray* plantPlotXPos=[NSMutableArray new];
    NSMutableArray* plantPlotYPos=[NSMutableArray new];
    NSMutableArray* plantPlotName=[NSMutableArray new];
    NSMutableArray* plantPlotANCode=[NSMutableArray new];
    NSMutableArray* plantPlotQRCode=[NSMutableArray new];
    for (int i=0; i<[[json valueForKey:@"plantPlots"]count]; i++) {
        
        [plantPlotID addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"ID"]];
        [plantPlotConfID addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"IDConf"]];
        [plantPlotPlantID addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"IDPlant"]];
        [plantPlotXPos addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"xPos"]];
        [plantPlotYPos addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"yPos"]];
        [plantPlotName addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"Name"]];
        [plantPlotANCode addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"ANCode"]];
        [plantPlotQRCode addObject:[[[json valueForKey:@"plantPlots"] objectAtIndex:i] valueForKey:@"QRCode"]];
    }
    
    //session
    
    NSMutableArray* sessionID=[NSMutableArray new];
    NSMutableArray* sessionConfID=[NSMutableArray new];
    NSMutableArray* sessionName=[NSMutableArray new];
    NSMutableArray* sessionRating=[NSMutableArray new];
    NSMutableArray* sessionCount=[NSMutableArray new];
    NSMutableArray* sessionPlantPlotID=[NSMutableArray new];
    NSMutableArray* sessionDescription=[NSMutableArray new];
    NSMutableArray* sessionDateTime=[NSMutableArray new];
    NSMutableArray* sessionType=[NSMutableArray new];
	NSMutableArray* sessionSpeaker=[NSMutableArray new];
    NSMutableArray* sessionAuthor=[NSMutableArray new];
    NSMutableArray* sessionNeeds=[NSMutableArray new];
    for (int i=0; i<[[json valueForKey:@"session"]count]; i++) {
        
        [sessionID addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"ID"]];
        [sessionConfID addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"IDConf"]];
        [sessionName addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Name"]];
        [sessionRating addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Rating"]];
        [sessionCount addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Count"]];
        [sessionPlantPlotID addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"IDPlantPlot"]];
        [sessionDescription addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Description"]];
        [sessionDateTime addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"DateTime"]];
        [sessionType addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Type"]];
		[sessionSpeaker addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Speaker"]];
        [sessionAuthor addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Author"]];
        [sessionNeeds addObject:[[[json valueForKey:@"session"] objectAtIndex:i] valueForKey:@"Needs"]];
    }
    
    if(true==YES){
        NSLog(@"This is a test!");
    }
    
    
}




//dado o confID e a variavel paperPath (ex.: @"paper.pdf")
//devolve o caminho absoluto ate ao ficheiro
-(NSString*)getPaper:(NSString*)confID : (NSString*)paperPath{
    
    return [NSString stringWithFormat:@"%@%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/",paperPath];
    
}

//updates all conference information that is on disc
-(void)updateConferences{
	NSArray*tmp=[self loadConfsIDs];
	for (int i=0; i<[tmp count]; i++) {
        NSData* tmpData=[self getConf:[tmp objectAtIndex:i]];
        if(tmpData!=NULL){
            NSDictionary* tmpConf=[self parseJSON:tmpData];
            [self saveConf:tmpConf:tmpData];
        }
    }
    
}


//saves an NSDictionary to the file agenda.info inside de folder of the correspondent conference
-(void)saveAgenda:(NSDictionary*)sessions : (NSString*)confID{
    NSString* savePath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/agenda.info"];

    [sessions writeToFile:savePath atomically:YES];


}

//loads an NSDictionary from the file agenda.info inside de folder of the correspondent conference
-(NSDictionary*)loadAgenda:(NSString*)confID{
    NSString* loadPath=[NSString stringWithFormat:@"%@%@%@%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0],@"/",confID,@"/agenda.info"];

    NSDictionary* sessions=[NSDictionary dictionaryWithContentsOfFile:loadPath];
    if(sessions==nil){//no file or could not retrieve then create new one
        [[NSDictionary new] writeToFile:loadPath atomically:YES];
    }
    return sessions;
}



@end