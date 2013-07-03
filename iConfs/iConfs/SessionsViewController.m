//
//  SessionsViewController.m
//  iConfs
//
//  Created by Ana T on 24/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "SessionsViewController.h"
#import "Session.h"
#import "SuperSession.h"
#import "Conference.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "PDFReader.h"
#import "SScell.h"
#import "PeopleViewController.h"
#import "PeopleCell.h"


@interface SessionsViewController (){

    Session *selectedSession;
    SuperSession *selectedSuperSession;
    Conference *conf;
    NSArray *sessions;
    NSArray *superSessions;
    NSMutableArray *autores;
    NSMutableArray *searchSessions;
    BOOL givenSession;
    BOOL searchItem;
    int ssIndex;
    MenuViewController *menu;
    int load;
    IBOutlet UIButton *r2;
    
    IBOutlet UIButton *r5;
    IBOutlet UIButton *r4;
    IBOutlet UIButton *r3;
    IBOutlet UIButton *r1;
    //usado para o rating
    NSString *sessionID;
    NSString *confID;
    IBOutlet UIButton *seeMoreButton;
    IBOutlet UILabel *seeMoreLabel;

}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SessionsViewController
@synthesize collection,sessionsTable,BackButton, abstract,AuthorsTable,HomeButton,MenuButton,ConferenceHome,previous;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        load=0;
        givenSession=NO;
    }
    return self;
}


//sets rating, this function shouldn't be here but I can' access IConfs to call the original...
-(BOOL)setRating:(NSString*)confyID : (NSString*)sessionyID : (NSInteger)rating{
    
    NSString* post=[NSString stringWithFormat:@"%@%@%@%@%@%ld%@",@"Conf=",confyID,@"&&Session=",sessionyID,@"&&Rating=",(long)rating,@"&SubmitCheck=Sent"];
    NSData* postData=[post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString* postLength=[NSString stringWithFormat:@"%d",[postData length]];
    
    NSMutableURLRequest* request=[[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://193.136.122.141/ratingSet.php"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    [request setTimeoutInterval:5];
    
    
    NSURLResponse* response;
    NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if(data!=nil){
        [self checkRatingButtons];
        return YES;
    }else {
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Rating error"
                                                        message:@"Please check your Internet Connection"
                                                       delegate:nil
                                              cancelButtonTitle:@"Back"
                                              otherButtonTitles:nil];
        [alert show];

        
        
        return NO;}
    
}

//-(void)vote:(int)value event:(int)eventID Confeference:(NSString*)cID;
//
//-(int)getVote:(int)eventID Confeference:(NSString*)cID;


- (IBAction)rate1:(id)sender {
  BOOL success=  [self setRating:confID:sessionID:1];
    if(success){
    [selectedSession vote:1];

    [self checkRatingButtons];
    IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
  //  [ic  vote:1 event:[selectedSession getID] Confeference:[conf getID]];
    }
    
}

- (IBAction)rate2:(id)sender {
    BOOL success=  [self setRating:confID:sessionID:2];
    if(success){    [selectedSession vote:3];
    IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    //[ic  vote:2 event:[selectedSession getID] Confeference:[conf getID]];

    [self checkRatingButtons];
    }
}

- (IBAction)rate3:(id)sender {
    BOOL success=  [self setRating:confID:sessionID:3];
    if(success){
        IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];

  //  [ic  vote:3 event:[selectedSession getID] Confeference:[conf getID]];

    [selectedSession vote:3];
    [self checkRatingButtons];
    }
}

- (IBAction)rate4:(id)sender {
    BOOL success=  [self setRating:confID:sessionID:4];
    if(success){    IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];

    [selectedSession vote:4];
 //   [ic  vote:4 event:[selectedSession getID] Confeference:[conf getID]];


    [self checkRatingButtons];
    }
}

- (IBAction)rate5:(id)sender {
    IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];

    BOOL success=  [self setRating:confID:sessionID:1];
    if(success){    [selectedSession vote:5];
 //   [ic  vote:5 event:[selectedSession getID] Confeference:[conf getID]];

    [self checkRatingButtons];
    }
}




-(void)auxChangeSuperSession:(int)index{
    givenSession=YES;
    [self.sessionsTable setDataSource:self];
    [self.sessionsTable setDelegate:self];
    [self.collection setDataSource:self];
    [self.collection setDelegate:self];
    
    conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];
    superSessions=[[conf getSuperSessions] allValues];
    selectedSuperSession =[[[conf getSuperSessions]allValues] objectAtIndex:index];
    sessions=[selectedSuperSession getSessionsOrderedByDate];
    
    
    
    
    
    [collection reloadData];
    
    
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForItem:index inSection:0 ];
    
    [collection reloadData];
    [collection selectItemAtIndexPath:indexPath animated:TRUE scrollPosition:UICollectionViewScrollPositionNone ];
    
   // [[collection delegate] collectionView:collection didDeselectItemAtIndexPath:indexPath];
    ssIndex=index;
    [collection reloadData];

}



-(void)changeSession:(int)indexSession{
    selectedSession =[sessions objectAtIndex:indexSession];
    
    
    //usado para o rating
    confID=conf.getID;
    int tmpy=selectedSession.getID;
    //STUPID THING I HAD TO MAKE BECAUSE YOU CONVERTED THE GODDAMN ID TO A INT!!!
    //THIS TYPE OF PROGRAMMING SUCKS!!!
    if(tmpy<10)
        sessionID= [NSString stringWithFormat:@"%@%i",@"s00",selectedSession.getID];
    else if(tmpy<100)
        sessionID= [NSString stringWithFormat:@"%@%i",@"s0",selectedSession.getID];
    else
        sessionID= [NSString stringWithFormat:@"%@%i",@"s",selectedSession.getID];
    self.RatingLabel.text=[NSString stringWithFormat:@"%@%.1f",@"Rating: ",selectedSession.getRateTrue];
    
    [self checkRatingButtons];

    
    //////////////////////////////////////
    
    
    [collection reloadData];

    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:indexSession inSection:0 ];
//    confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getAuthors];
    
//    receivedAuthor=YES;
    [sessionsTable reloadData];
    [sessionsTable
     selectRowAtIndexPath:indexPath
     animated:TRUE
     scrollPosition:UITableViewScrollPositionNone
     ];
    
    [[sessionsTable delegate]
     tableView:sessionsTable
     didSelectRowAtIndexPath:indexPath
     ];
    
    
}


-(void)checkRatingButtons{
    [r1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [r2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [r3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [r4 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [r5 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    
    [r1 setEnabled:YES];
    [r2 setEnabled:YES];
    [r3 setEnabled:YES];
    [r4 setEnabled:YES];
    [r5 setEnabled:YES];
    
    if(selectedSession !=nil&& conf!=nil){
    IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
        conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController]selectedConf];
  // int v=[ ic getVote:[selectedSession getID] Confeference:[conf getID]];
        int v=[selectedSession getVote];
    if(v !=0){
    
        if(v ==1){
            [r1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

            
            [r1 setSelected:YES];

            }

        
      else  if(v ==2){
            [r2 setSelected:YES];
          [r2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

          
        }
     else   if(v ==3){
            [r3 setSelected:YES];
         [r3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        }
     else   if(v ==4){
            [r4 setSelected:YES];
         [r4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        }
        else            {
            [r5 setSelected:YES];
            [r5 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

        }
        
        
        
        [r1 setEnabled:NO];
        [r2 setEnabled:NO];
        [r3 setEnabled:NO];
        [r4 setEnabled:NO];
        [r5 setEnabled:NO];

        [self.view setNeedsDisplay];
    }
    }
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.AuthorsTable setDataSource:self];
    [self.sessionsTable setDataSource:self];
    [self.AuthorsTable setDelegate:self];
    [self.sessionsTable setDelegate:self];
    [[self searchBar]setDelegate:self];
    [self.collection setDataSource:self];
    [self.collection setDelegate:self];

    searchItem = NO;

  
    
    
    
        



//    menu=(MenuViewController*)[[self slidingViewController] underLeftViewController] ;
    

        //selecciona a 1ª Supersessao por defeito
    if(selectedSession==nil&&load==0){
        conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];


        sessions=[[NSArray alloc]init];
        superSessions=[[NSArray alloc]init];
        autores=[[NSMutableArray alloc]init];
        searchSessions = [[NSMutableArray alloc] init];

        superSessions=[[conf getSuperSessions]allValues];

        
        ssIndex=0;
        selectedSuperSession = [superSessions objectAtIndex:ssIndex];

        sessions=[selectedSuperSession getSessionsOrderedByDate];

        
        //escolhe por defeito a sessão
        
        selectedSession =[[selectedSuperSession getSessionsOrderedByDate]objectAtIndex:0];
    
        [self checkRatingButtons];
        
        //usado para o rating
        confID=conf.getID;
        int tmpy=selectedSession.getID;
        //STUPID THING I HAD TO MAKE BECAUSE YOU CONVERTED THE GODDAMN ID TO A INT!!!
        //THIS TYPE OF PROGRAMMING SUCKS!!!
        if(tmpy<10)
            sessionID= [NSString stringWithFormat:@"%@%i",@"s00",selectedSession.getID];
        else if(tmpy<100)
            sessionID= [NSString stringWithFormat:@"%@%i",@"s0",selectedSession.getID];
        else
            sessionID= [NSString stringWithFormat:@"%@%i",@"s",selectedSession.getID];
        self.RatingLabel.text=[NSString stringWithFormat:@"%@%.1f",@"Rating: ",selectedSession.getRateTrue];
        
        
        
        
        
        //adicionar abstract e autores
    
  //      [abstract setText:[selectedSession getTheme]];
        
   
    
    NSDate* currentDate = [NSDate date];
   // [currentDate setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"WEST"]];

    NSString* dateInString = [currentDate description];

    NSLog(@"Horassss : %@",dateInString);
        [[[self view] layer] setShadowOpacity:0.75f];
        [[[self view] layer] setShadowRadius:10.0f];
        [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
        
        if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
            [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
        }
        
   //     [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
        
        [self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
        
        [MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
        [MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
        [MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self view] addSubview:MenuButton];
        
        
        [self setHomeButton:[UIButton buttonWithType:UIButtonTypeCustom]];
        
        [HomeButton setFrame:CGRectMake(45, 0, 43, 40)];
        [HomeButton setBackgroundImage:[UIImage imageNamed:@"white_home.png"] forState:UIControlStateNormal];
        [HomeButton addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self view] addSubview:HomeButton];
        
        
        
//        [self setConferenceHome:[UIButton buttonWithType:UIButtonTypeCustom]];
//        
//        [ConferenceHome setFrame:CGRectMake(717, 4, 43, 40)];
//        [ConferenceHome setBackgroundImage:[UIImage imageNamed:@"white_home_conf2.png"] forState:UIControlStateNormal];
//        [ConferenceHome addTarget:self action:@selector(goToConferenceHome:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [[self view] addSubview:ConferenceHome];

        [self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
        
        [BackButton setFrame:CGRectMake(717, 4, 43, 40)];
        [BackButton setBackgroundImage:[UIImage imageNamed:@"back3.png"] forState:UIControlStateNormal];
        [BackButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self view] addSubview:BackButton];
    }
    
    
    
      load++;
    
    
    
    
    
    //////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////
    
    //DEBUG EDUARDO

    int x=[selectedSession getPaperID];
    if(x !=-1){
        [seeMoreButton setHidden:NO];
        [seeMoreLabel setText:@"See more in Paper"];
        Session *s=selectedSession;
        Author *as=[s getAuthor];
        NSInteger authorID = [[selectedSession getAuthor] getID];
        NSArray *confAuthors=[conf getAuthors];
        Author* aut = [conf getAuthorByID:authorID];
        Paper *p=[aut getPaper: x]; 
        autores=[[NSMutableArray alloc]init ];
        for( NSString *id in[p getAuthors]){
            int currAuthorID = [[[id componentsSeparatedByString:@"p"] objectAtIndex: 1]intValue];
            Author* currAuthor = [conf getAuthorByID:currAuthorID];
            [autores addObject:currAuthor];
        }
           
    }
else{
    autores =[[NSMutableArray alloc]init];
    [seeMoreButton setHidden:YES];
    [seeMoreLabel setText:@"No Paper available"];
}


    [abstract setText:[selectedSession getTheme]];

    


	// Do any additional setup after loading the view. 
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"GB.jpg"]];
    self.view.backgroundColor = background;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [superSessions count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView.tag==1){
       if (!searchItem)
    return [sessions count];
       else return [searchSessions count];

    }
    
    else{
     return   [autores count];
    
    }

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (tableView.tag)
    {
        case 1:
            sectionName = NSLocalizedString(@"Presentations", @"mySectionName");
            break;
        case 2:
            sectionName = NSLocalizedString(@"Paper Authors", @"myOtherSectionName");
            break;
    }
    
    return sectionName;
}
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //sessionsTable
    UITableViewCell *cell;
    if([tableView tag]==1){
        cell=[tableView dequeueReusableCellWithIdentifier:@"sessionCell" forIndexPath:indexPath];

              if (!searchItem) {

        
        
        Session *s=[sessions objectAtIndex:indexPath.row];
                  NSString *x=[s getTitle];
                  NSString *y=[s getTheme];
                  NSLog(@"X =%@ Y =%@", x,y);
                  NSArray *aut=autores;
        [[cell textLabel]setText:[s getTitle]];
        
;
              
                  if(indexPath.row==0&&!givenSession){
                      [sessionsTable
                       selectRowAtIndexPath:indexPath
                       animated:TRUE
                       scrollPosition:UITableViewScrollPositionNone
                       ];
                      
                      [[sessionsTable delegate]
                       tableView:sessionsTable
                       didSelectRowAtIndexPath:indexPath
                       ];
                  }
              
              }
              else{
                  
                  Session *s=[searchSessions objectAtIndex:indexPath.row];
                  [[cell textLabel]setText:[s getTitle]];
              
            
                  if(indexPath.row==0){
                  [sessionsTable
                   selectRowAtIndexPath:indexPath
                   animated:TRUE
                   scrollPosition:UITableViewScrollPositionNone
                   ];
                  
                  [[sessionsTable delegate]
                   tableView:sessionsTable
                   didSelectRowAtIndexPath:indexPath
                   ];
              }
}
    }
    //autores table
    else if([tableView tag]==2){
          cell=[tableView dequeueReusableCellWithIdentifier:@"authorCell" forIndexPath:indexPath];
    
        if([autores count]!=0){
            
            [[cell textLabel] setText:[[autores objectAtIndex:indexPath.row] getName]];
            [[cell detailTextLabel] setText:[[autores objectAtIndex:indexPath.row] getWork]];

//            int i = indexPath.row;
//            NSString* currIDUnparsed = [autores objectAtIndex:indexPath.row];
//            int currAuthorID = [[[currIDUnparsed componentsSeparatedByString:@"p"] objectAtIndex: 1]intValue];
//            Author* currAuthor = [conf getAuthorByID:currAuthorID];
//            [[cell textLabel]setText:[currAuthor getName]];
        }

    }
    return  cell;

}
    




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  //  selectedSS
  //  nonSelectedSS
    static NSString *CellIdentifier;
    if(indexPath.item==ssIndex){
    CellIdentifier=@"selectedSS";
        
    }
    else{
        CellIdentifier=@"nonSelectedSS";

    }
    
    SScell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    SuperSession *ss=[superSessions objectAtIndex:indexPath.item];
    [[cell sessionName] setText:[ss getTheme]];
 
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==1){
    
    selectedSession=[sessions objectAtIndex:indexPath.row];
        int x=[selectedSession getPaperID];
        if(x !=-1){
            Session *s=selectedSession;
            Author *as=[s getAuthor];
            NSInteger authorID = [[selectedSession getAuthor] getID];
            NSArray *confAuthors=[conf getAuthors];
            Author* aut = [conf getAuthorByID:authorID];
            Paper *p=[aut getPaper: x];
            autores=[[NSMutableArray alloc]init ];
            for( NSString *id in[p getAuthors]){
                int currAuthorID = [[[id componentsSeparatedByString:@"p"] objectAtIndex: 1]intValue];
                Author* currAuthor = [conf getAuthorByID:currAuthorID];
                [autores addObject:currAuthor];
            }
         
            [AuthorsTable reloadData];
        }
    [self checkRatingButtons];

    
    
    //usado para o rating
    confID=conf.getID;
    int tmpy=selectedSession.getID;
    //STUPID THING I HAD TO MAKE BECAUSE YOU CONVERTED THE GODDAMN ID TO A INT!!!
    //THIS TYPE OF PROGRAMMING SUCKS!!!
    if(tmpy<10)
        sessionID= [NSString stringWithFormat:@"%@%i",@"s00",selectedSession.getID];
    else if(tmpy<100)
        sessionID= [NSString stringWithFormat:@"%@%i",@"s0",selectedSession.getID];
    else
        sessionID= [NSString stringWithFormat:@"%@%i",@"s",selectedSession.getID];
    self.RatingLabel.text=[NSString stringWithFormat:@"%@%.1f",@"Rating: ",selectedSession.getRateTrue];
    

    [abstract setText:[selectedSession getTheme]];
    [self viewDidLoad];
    
    [AuthorsTable reloadData];
    }
    else{
    
        
        
        NSString *iD = @"People";
        
        PeopleViewController *newTopViewController =[[self storyboard]instantiateViewControllerWithIdentifier:iD];
        int index = 0;
        Author *currentAuthor;
        if([autores count]!=0){
        currentAuthor=[autores objectAtIndex:indexPath.row];
        }
        for(int i=0;i<[[conf getAuthors] count];i++){
            Author * aut=[[conf getAuthors] objectAtIndex:i];
            
            if([aut getID]==[currentAuthor getID]){
            
                index=i;
                break;
            }
            
            
        }
        [newTopViewController changePrevious:self];

        [newTopViewController changeAuthor:index];
        
        [newTopViewController viewDidLoad];
        
        [newTopViewController changeAuthor:index];
        
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        [newTopViewController changeAuthor:index];
    
    
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ssIndex=indexPath.item;
    
    selectedSuperSession=[superSessions objectAtIndex:ssIndex];
    
    sessions=[selectedSuperSession getSessionsOrderedByDate];

    
    [collection reloadData];
    [sessionsTable reloadData];
    //no array de blueprints vai buscar o com index indexPath.item e depois
    //tem de reflectir essa escolha na planta mostrada ao user.
    
//    NSArray *keys = [self.blueprints allKeys];
//    id aKey = [keys objectAtIndex:indexPath.item];
//    Blueprints *b = [self.blueprints objectForKey:aKey];
//    selectedBlueprint=b;
//    
//    [self changeSelectedBlueprint:b];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openPaper:(id)sender {
    
   IConfs *ic= [(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    int auxPaperID=[selectedSession getPaperID];
    NSString* stringPaperID;
    if(auxPaperID>10){
        stringPaperID = [@"p0" stringByAppendingFormat:@"%i", auxPaperID];

    }
    else{
    stringPaperID = [@"p00" stringByAppendingFormat:@"%i", auxPaperID];
        NSLog(@"%@",stringPaperID);
    }

    
   NSString *auxpaperPath=[[[autores objectAtIndex:0] getPaper:[selectedSession getPaperID]]getLink];

    NSString *iD = @"PDFReader";
    PDFReader *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    NSString *paperPath=    [ic getPaper:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf]getID]:auxpaperPath];

    
    
    [newTopViewController changePath:paperPath];
    [newTopViewController changeToFullScreen];
    [newTopViewController changePrevious:self];
    [newTopViewController viewDidLoad];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];

    
    
}

- (IBAction)goHome:(id)sender{
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    [(MenuViewController*)[[self slidingViewController] underLeftViewController] deselectConf];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
}


- (IBAction)goBack:(id)sender{
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    if(previous!=nil)
    [[self slidingViewController] setTopViewController:previous];
    else{
    
        NSString *iD = @"Conference";
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        [[self slidingViewController] setTopViewController:newTopViewController];

    }
    [[[[self slidingViewController] topViewController] view] setFrame:frame];

}

- (IBAction)goToConferenceHome:(id)sender{
    
    NSString *iD = @"Conference";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchSessions = [[NSMutableArray alloc] init];
    
    if ([searchText length] == 0) {
        searchItem = NO;
    }else {
        searchItem = YES;
        
        NSString *strName = [[NSString alloc]init];
        NSString *strCompany = [[NSString alloc]init];
        
        for (int i = 0; i < [sessions count]; i++) {
            strName = [[sessions objectAtIndex:i] getTitle];
            
            NSRange stringRangeName = [strName rangeOfString:searchText options:NSCaseInsensitiveSearch];
           // NSRange stringRangeCompany = [strCompany rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRangeName.location != NSNotFound) {
                [searchSessions addObject:[sessions objectAtIndex:i]];
            }
        }
    }
    
    [[self sessionsTable]reloadData];
}



- (void)changePrevious:(UIViewController*)vc{
    
    previous=vc;
    
}
- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}
@end
