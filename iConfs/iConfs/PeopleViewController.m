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

@interface PeopleViewController ()
{
    NSArray *confPeople;
    NSMutableArray *confSearchPeople;
    BOOL searchItem;
}
@end

@implementation PeopleViewController

@synthesize MenuButton,peopleTable,noSelectionLabel,personNameBar,iConfsImage,speakerBio,BIO;

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
    
    
    [[self peopleTable] setDelegate:self];
    [[self peopleTable] setDataSource:self];
    [[self Search]setDelegate:self];
    
    searchItem = NO;
    
    confSearchPeople = [[NSMutableArray alloc] init];
    
    confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];
    
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

//collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!searchItem)
        return [confPeople count];
    else
        return [confSearchPeople count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"peopleCell" forIndexPath:indexPath];
    
        
  //  NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    
    if (!searchItem) {
     //   [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confPeople objectAtIndex:[indexPath row]] getImagePath]]];
        
        [[cell textLabel]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getName]];
        [[cell detailTextLabel]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getWork]];
    }else {
     //   [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getImagePath]]];
        [[cell textLabel]setText:[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getName]];
        [[cell detailTextLabel]setText:[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getWork]];
    }
    
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
        
    }
    
    
    
    
    if ([[confPeople objectAtIndex:indexPath.row] isKindOfClass:[Author class]]) {
        Author *a=[confPeople objectAtIndex:indexPath.row];
        
        
        
        
    }
    
    else{
        
        Organizer *o =[confPeople objectAtIndex:indexPath.row];
    
    
    }
    
    Person  *p= [confPeople objectAtIndex:indexPath.row];
    
    [personNameBar setTitle:[p getName]];
    
//    UIViewController *newTopViewController;
//    
//    if ([[self Options] selectedSegmentIndex] != 2){
//        newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Person"];
//        
//        if (searchItem)
//            [(PersonViewController *)newTopViewController setShownPerson:[confSearchPeople objectAtIndex:[indexPath row]]];
//        else
//            [(PersonViewController *)newTopViewController setShownPerson:[confPeople objectAtIndex:[indexPath row]]];
//    }else{
//        newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Organizer"];
//        
//        if (searchItem)
//            [(OrganizerViewController *)newTopViewController setShownPerson:(Organizer *)[confSearchPeople objectAtIndex:[indexPath row]]];
//        else
//            [(OrganizerViewController *)newTopViewController setShownPerson:(Organizer *)[confPeople objectAtIndex:[indexPath row]]];
//    }
//    
//    [[self slidingViewController] setTopViewController:newTopViewController];
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

@end
