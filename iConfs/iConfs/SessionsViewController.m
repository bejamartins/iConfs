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
    NSArray *autores;
    NSMutableArray *searchSessions;
    BOOL searchItem;

    
}

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SessionsViewController
@synthesize collection,sessionsTable, abstract,AuthorsTable,HomeButton,MenuButton,ConferenceHome,previous;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.AuthorsTable setDataSource:self];
    [self.sessionsTable setDataSource:self];
    [self.AuthorsTable setDelegate:self];
    [self.sessionsTable setDelegate:self];
    [[self searchBar]setDelegate:self];
    searchItem = NO;

   
    
    
    
    
        
    sessions=[[NSArray alloc]init];
    superSessions=[[NSArray alloc]init];
    autores=[[NSArray alloc]init];
    searchSessions = [[NSMutableArray alloc] init];



        conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];
    
    sessions=[selectedSuperSession getSessionsOrderedByDate];
    
    superSessions=[[conf getSuperSessions]allValues];

        //selecciona a 1ª Supersessao por defeito
    if(selectedSession==nil){

 
        selectedSuperSession = [superSessions objectAtIndex:0];
        
        //escolhe por defeito a sessão
        
      //  selectedSession =[[selectedSuperSession getSessionsOrderedByDate]objectAtIndex:0];
      //  [[selectedSuperSession getSessionsOrderedByDate]objectAtIndex:0];
    
        //adicionar abstract e autores
    
    //    [abstract setText:[selectedSession getTheme]];
        
    }
    
    //se foi dada uma sessão para dar detalhes.
    else{
    
        //selectedSuperSession=[selectedSession  getS]; //MUDAR
    
    }
    //mudar
   // autores=[selectedSession getAuthor];
  //  [abstract setText:[selectedSession getTheme]];

    
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
    }
    
    [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
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
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //sessionsTable
    if([tableView tag]==1){
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"sessionCell" forIndexPath:indexPath];
        
        
        [[cell textLabel]setText:[[sessions objectAtIndex:indexPath.row]getName]];
        
        //  NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
        
  //      if (!searchItem) {
            //   [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confPeople objectAtIndex:[indexPath row]] getImagePath]]];
            
        //    [[cell textLabel]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getName]];

    
    
    }
    //autores table
    else if([tableView tag]==2){
         UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"authorCell" forIndexPath:indexPath];
    
        
        [[cell textLabel]setText:[[autores objectAtIndex:indexPath.row]getName]];

    }


}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
  //  selectedSS
  //  nonSelectedSS
    static NSString *CellIdentifier;
    if([[superSessions objectAtIndex:indexPath.item]isEqual:selectedSuperSession]){
    CellIdentifier=@"selectedSS";
    }
    else{
        CellIdentifier=@"nonSelectedSS";

    }
    
    SScell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [[cell sessionName] setText:[superSessions objectAtIndex:indexPath.item]];
    
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
    
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
            strName = [[sessions objectAtIndex:i] getName];
            
            NSRange stringRangeName = [strName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange stringRangeCompany = [strCompany rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRangeName.location != NSNotFound || stringRangeCompany.location != NSNotFound) {
                [searchSessions addObject:[sessions objectAtIndex:i]];
            }
        }
    }
    
    [[self sessionsTable]reloadData];
}



- (void)changePrevious:(UIViewController*)vc{
    
    previous=vc;
    
}
@end
