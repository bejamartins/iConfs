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
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SessionsViewController
@synthesize collection,sessionsTable, abstract,AuthorsTable,HomeButton,MenuButton,ConferenceHome,previous;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        load=0;
        givenSession=NO;
    }
    return self;
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
    //seleciona autor
    selectedSession =[sessions objectAtIndex:indexSession];

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
        autores=[[NSArray alloc]init];
        searchSessions = [[NSMutableArray alloc] init];

        superSessions=[[conf getSuperSessions]allValues];

        
        ssIndex=0;
        selectedSuperSession = [superSessions objectAtIndex:ssIndex];

        sessions=[selectedSuperSession getSessionsOrderedByDate];

        
        //escolhe por defeito a sessão
        
        selectedSession =[[selectedSuperSession getSessionsOrderedByDate]objectAtIndex:0];
    
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
        
        
        
        [self setConferenceHome:[UIButton buttonWithType:UIButtonTypeCustom]];
        
        [ConferenceHome setFrame:CGRectMake(717, 4, 43, 40)];
        [ConferenceHome setBackgroundImage:[UIImage imageNamed:@"white_home_conf2.png"] forState:UIControlStateNormal];
        [ConferenceHome addTarget:self action:@selector(goToConferenceHome:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self view] addSubview:ConferenceHome];


    }
    
    
    
      load++;
    
    
    
    
    
    //////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////
    
    //DEBUG EDUARDO
    
    int x=[selectedSession getPaperID];
    if(x !=-1){
    int authorID = [[selectedSession getAuthor] getID];
        Author *aut=(Author*)[selectedSession getAuthor];
    Paper *p=[aut getPaper: x];
        autores=[[NSMutableArray alloc]init ];
        for( NSString *id in[p getAuthors]){
    [autores addObject:[conf geta]];
        }
    
    }
    
    [abstract setText:[selectedSession getTheme]];

    
  


	// Do any additional setup after loading the view.
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
    if (!searchItem)
    return [sessions count];
    else return [searchSessions count];

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
        
        //  NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
        
  //      if (!searchItem) {
            //   [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confPeople objectAtIndex:[indexPath row]] getImagePath]]];
            
        //    [[cell textLabel]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getName]];
              
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
            int i = indexPath.row;
            NSString* currIDUnparsed = [autores objectAtIndex:indexPath.row];
            int currAuthorID = [[[currIDUnparsed componentsSeparatedByString:@"p"] objectAtIndex: 1]intValue];
            Author* currAuthor = [conf getAuthorByID:currAuthorID];
            [[cell textLabel]setText:[currAuthor getName]];
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
    NSString *x =[ss getTheme];
    NSLog(@"Theme da sessão: %@",x);
//    NSArray *keys = [self.blueprints allKeys];
//    NSString *key = [keys objectAtIndex:indexPath.item];
//    // NSLog(@"Vou buscar o 1º Mapa! :D item=%d",indexPath.item );
//    Blueprints *bp=[self.blueprints objectForKey:key];
//    // NSLog(self.blueprints);
//    NSString *imagePath=[bp getImagePath];
//    //   UIImage *graphImage = [[UIImage alloc] initWithContentsOfFile: imagePath];
//    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedSession=[sessions objectAtIndex:indexPath.row];


    //adicionar abstract e autores
    
    [abstract setText:[selectedSession getTheme]];
    [self viewDidLoad];
    
    [AuthorsTable reloadData];
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
    NSString *iD = @"PDFReader";
    PDFReader *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    NSString *paperPath=[[[autores objectAtIndex:0] getPaper:[selectedSession getPaperID]]getLink];
    [newTopViewController changePath:paperPath];
    [newTopViewController changeToFullScreen];
    [newTopViewController changePrevious:self];
    [newTopViewController viewDidLoad];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];

    
    
}

- (IBAction)goHome:(id)sender{
    
  //  menu=(MenuViewController*)[[self slidingViewController] underLeftViewController] ;

    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];

    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];

    

    [menu setSelectedConf:nil];
    [[menu MenuView ]reloadData];
}


//- (IBAction)goBack:(id)sender{
//    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
//    [[self slidingViewController] setTopViewController:previous];
//    [[[[self slidingViewController] topViewController] view] setFrame:frame];
//
//}

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
