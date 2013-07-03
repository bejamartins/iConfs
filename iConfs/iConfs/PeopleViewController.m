//
//  PeopleViewController.m
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "PeopleViewController.h"
#import "PeopleCell.h"
#import "PersonViewController.h"
#import "OrganizerViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "Speaker.h"
#import "PDFReader.h"


@interface PeopleViewController ()
{
    MenuViewController *menu;
    BOOL receivedAuthor;

    NSArray *confPeople;
    NSMutableArray *confSearchPeople;
    BOOL searchItem;
    IBOutlet UIView *sessionView;
    
    IBOutlet UILabel *sessionName;
    IBOutlet UIToolbar *toolbarAgenda;
    
    
    IBOutlet UIButton *seePaperButton;
    IBOutlet UIPageControl *pageControl;
    
    IBOutlet UILabel *PresentationName;
    
    IBOutlet UILabel *sessionDate;
    
    NSMutableArray *sessions;
    
    
    IBOutlet UIView *pdfPreview;
    
    NSString *paperPath;
    NSArray *authores;
    Author *currentAuthor;
    
    IBOutlet UITableView *paperCollection;
    
}
@end

@implementation PeopleViewController

@synthesize MenuButton,peopleTable,noSelectionLabel,personNameBar,iConfsImage,speakerBio,BIO,HomeButton,ConferenceHome,previous,segmentedControl,BackButton;


-(void)changeAuthor:(int)index{
    //seleciona autor
    
    [segmentedControl setSelectedSegmentIndex:1];
    [[self Options]setSelectedSegmentIndex:1];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0 ];
    confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getAuthors];
    
    receivedAuthor=YES;
    [peopleTable reloadData];
    [peopleTable
     selectRowAtIndexPath:indexPath
     animated:TRUE
     scrollPosition:UITableViewScrollPositionNone
     ];
    
    [[peopleTable delegate]
     tableView:peopleTable
     didSelectRowAtIndexPath:indexPath
     ];
    
    
}
- (IBAction)openPDF:(id)sender {
    
    if(![pdfPreview isHidden]){
    
    NSString *iD = @"PDFReader";
    PDFReader *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        [newTopViewController changePath:paperPath];
    [newTopViewController changeToFullScreen];
    [newTopViewController changePrevious:self];

    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    }
//  PDFReader *reader = (PDFReader*)[[self slidingViewController] topViewController];
//    [reader changePath:paperPath];

    
}



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
	// Do any additional setup after loading the view.
    
  //  [[self PeopleCollection]setDelegate:self];
  //  [[self PeopleCollection]setDataSource:self];
    
    
    [paperCollection setDelegate:self];
    [paperCollection setDataSource:self];
    [[self peopleTable] setDelegate:self];
    [[self peopleTable] setDataSource:self];
    [[self Search]setDelegate:self];
    [sessionView setHidden:YES];
    searchItem = NO;
    receivedAuthor=NO;
    
    confSearchPeople = [[NSMutableArray alloc] init];
    authores = [[NSArray alloc] init];

    confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];
    authores = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];

    
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
    }
    
//    [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
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
    
    [ConferenceHome setFrame:CGRectMake(660, 4, 43, 40)];
    [ConferenceHome setBackgroundImage:[UIImage imageNamed:@"white_home_conf2.png"] forState:UIControlStateNormal];
    [ConferenceHome addTarget:self action:@selector(goToConferenceHome:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:ConferenceHome];

    
    [self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [BackButton setFrame:CGRectMake(717, 4, 43, 40)];
    [BackButton setBackgroundImage:[UIImage imageNamed:@"back3.png"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:BackButton];
    
    [self setHomeButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [HomeButton setFrame:CGRectMake(45, 0, 43, 40)];
    [HomeButton setBackgroundImage:[UIImage imageNamed:@"white_home.png"] forState:UIControlStateNormal];
    [HomeButton addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:HomeButton];
      menu=(MenuViewController*)[[self slidingViewController] underLeftViewController] ;

    

    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"GB.jpg"]];
    self.view.backgroundColor = background;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}

#pragma - Collection View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(tableView.tag==0){
    if (!searchItem)
        return [confPeople count];
    else
        return [confSearchPeople count];
    }
    
    
    
    
    if(tableView.tag ==1){
        return 0;
    
        NSIndexPath *ip=[peopleTable indexPathForSelectedRow];
        if([confPeople count]!=0&& ip.row<[confPeople count]){
            
            if([[confPeople objectAtIndex:ip.row] isKindOfClass:[Author class]]){
            
            
        currentAuthor=(Author*)[confPeople objectAtIndex:ip.row];
        
        
            return [[currentAuthor getAllPapers]count];
    
    
    }
        }

}
            return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==0){
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"peopleCell" forIndexPath:indexPath];
    
        
  //  NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    
    if (!searchItem) {
     //   [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confPeople objectAtIndex:[indexPath row]] getImagePath]]];
        
        [[cell textLabel]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getName]];
        [[cell detailTextLabel]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getWork]];
    }
    
    
    else {
        [[cell textLabel]setText:[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getName]];
        [[cell detailTextLabel]setText:[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getWork]];
    }
    
    if(indexPath.row==0&&!receivedAuthor){
    [peopleTable
     selectRowAtIndexPath:indexPath
     animated:TRUE
     scrollPosition:UITableViewScrollPositionNone
     ];
    
    [[peopleTable delegate]
     tableView:peopleTable
     didSelectRowAtIndexPath:indexPath
     ];
    }
    
    return cell;
    }
    
    else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"paperCell" forIndexPath:indexPath];

        
   NSIndexPath *ip=[peopleTable indexPathForSelectedRow];
        
        currentAuthor=(Author*)[confPeople objectAtIndex:ip.row];
        
        Paper *p=[[currentAuthor getAllPapers]objectAtIndex:indexPath.row ] ;
        
        [[cell textLabel]setText:[p getTitle]];
    
        
        
        
        
        if(indexPath.row==0){
            [paperCollection
             selectRowAtIndexPath:indexPath
             animated:TRUE
             scrollPosition:UITableViewScrollPositionNone
             ];
            
            [[paperCollection delegate]
             tableView:peopleTable
             didSelectRowAtIndexPath:indexPath
             ];
    
    
    }
    
    
    

}
    
}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(tableView.tag==0){
    if(![iConfsImage isHidden]){
    
        [iConfsImage setHidden:YES];
        [noSelectionLabel setHidden:YES];
      //  btn.titleLabel.font=[UIFont fontWithName:@"Helvetica neue" size:10];


    }
    
    
    if ([[confPeople objectAtIndex:indexPath.row] isKindOfClass:[Speaker class]]) {
        Speaker *s=[confPeople objectAtIndex:indexPath.row];
        
        [speakerBio setText:[s getResume]];
        [speakerBio setHidden:NO];
        [BIO setHidden:NO];
        [sessionView setHidden:YES];
        [pdfPreview setHidden:YES];
        [BIO setText:@"Bio"];
        [paperCollection setHidden:YES];

        
        NSArray *Events=[s getEventList];
        
        sessions=[[NSMutableArray alloc]init];
        
        for(int i=0;i<[Events count];i++){
            
            if([[Events objectAtIndex:i] isKindOfClass:[Session class]]){
                
                [sessions addObject:[Events objectAtIndex:i]];
                
            }
            
        }
        [pageControl setNumberOfPages: [sessions count]];
        
        
       [seePaperButton setHidden:YES];

        
    }
    
    
    
    
    if ([[confPeople objectAtIndex:indexPath.row] isKindOfClass:[Author class]]) {
        [paperCollection setHidden:NO];
        Author *a=[confPeople objectAtIndex:indexPath.row];
        [speakerBio setHidden:YES];
        [BIO setHidden:YES];
        
 //       [sessionView setHidden:NO];
        [seePaperButton setHidden:NO];

        
        NSArray *Events=[a getEventList];
        
        sessions=[[NSMutableArray alloc]init];
        
        for(int i=0;i<[Events count];i++){
            
            if([[Events objectAtIndex:i] isKindOfClass:[Session class]]){
            
                [sessions addObject:[Events objectAtIndex:i]];
            
            }
        
        }
        [pageControl setNumberOfPages: [sessions count]];
        [pdfPreview setHidden:NO];

        
        for( UIViewController *childViewController in [self childViewControllers]){
        
            
            if ([childViewController isKindOfClass:[PDFReader class]]){
          
                
               // Session *s=[sessions objectAtIndex:0] ;
                
                PDFReader *pr = (PDFReader *)childViewController;
              
               // NSString *paperPath=[[a getPaper:[s getPaperID]]getLink];
                 paperPath=@"pdf.pdf";
                [pr changePath:paperPath];
                [pr viewDidLoad];
                
                
            }

        
        }

        
        //  [sessionName setText:[[sessions objectAtIndex:0]getName]];
 //       [sessionDate setText:[[sessions objectAtIndex:0]getDate]];
        

    }
    
    else     if ([[confPeople objectAtIndex:indexPath.row] isKindOfClass:[Organizer class]]) {
        [paperCollection setHidden:YES];

        Organizer *o =[confPeople objectAtIndex:indexPath.row];
        [pdfPreview setHidden:YES];
        [sessionView setHidden:YES];
        [toolbarAgenda setHidden:YES];
        [BIO setHidden:NO];

        [speakerBio setHidden:NO];
        [BIO setText:@"Job Title"];
       [ speakerBio setText:[o getJob]];

    }
    
    Person  *p= [confPeople objectAtIndex:indexPath.row];
    
    [personNameBar setTitle:[p getName]];
    }
    
    
    
    //paper table!
    
    
    
    else{}

}

#pragma - Search Bar Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    confSearchPeople = [[NSMutableArray alloc] init];
    
    if ([searchText length] == 0) {
        searchItem = NO;
    }else {
        searchItem = YES;
        
        NSString *strName = [[NSString alloc]init];
        NSString *strCompany = [[NSString alloc]init];
        
        for (int i = 0; i < [confPeople count]; i++) {
            strName = [[confPeople objectAtIndex:i] getName];
            strCompany = [[confPeople objectAtIndex:i] getWork];
            
            NSRange stringRangeName = [strName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange stringRangeCompany = [strCompany rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRangeName.location != NSNotFound || stringRangeCompany.location != NSNotFound) {
                [confSearchPeople addObject:[confPeople objectAtIndex:i]];
            }
        }
    }
    
    [[self peopleTable]reloadData];
}

#pragma - Segmented Button Methods

- (IBAction)selectedOption:(id)sender {
    //[indexP];
    
    //[peopleTable selectRowAtIndexPath:indexPath animated:NO scrollPosition: UITableViewScrollPositionNone];
    
   
    
    if ([[self Options] selectedSegmentIndex] == 0) {
        confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];
        [[[self NavBar] topItem] setTitle:@"Speakers"];
    }else if ([[self Options] selectedSegmentIndex] == 1) {
        confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getAuthors];
        [[[self NavBar] topItem] setTitle:@"Authors"];
    }else {
        confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getOrganizers];
        [[[self NavBar] topItem] setTitle:@"Organizers"];
    }

    [[self peopleTable]reloadData];
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

- (void)changePrevious:(UIViewController*)vc{
    
    previous=vc;
    
}

- (IBAction)goToConferenceHome:(id)sender{
    
    NSString *iD = @"Conference";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];

}






@end
