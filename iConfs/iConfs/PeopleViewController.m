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
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface PeopleViewController ()
{
    NSArray *confPeople;
    NSMutableArray *confSearchPeople;
    BOOL searchItem;
}
@end

@implementation PeopleViewController

@synthesize MenuButton;

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
    
    [[self PeopleCollection]setDelegate:self];
    [[self PeopleCollection]setDataSource:self];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!searchItem)
        return [confPeople count];
    else
        return [confSearchPeople count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    PeopleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    
    if (!searchItem) {
        [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confPeople objectAtIndex:[indexPath row]] getImagePath]]];
        
        [[cell Name]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getName]];
        [[cell Company]setText:[(Person*)[confPeople objectAtIndex:[indexPath row]] getWork]];
    }else {
        [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getImagePath]]];
        [[cell Name]setText:[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getName]];
        [[cell Company]setText:[(Person*)[confSearchPeople objectAtIndex:[indexPath row]] getWork]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Person"];
    if (searchItem) {
        [(PersonViewController*)newTopViewController setShownPerson:[confSearchPeople objectAtIndex:[indexPath row]]];
    }else
        [(PersonViewController*)newTopViewController setShownPerson:[confPeople objectAtIndex:[indexPath row]]];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    [[self slidingViewController] resetTopView];
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
    
    [[self PeopleCollection]reloadData];
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

    [[self PeopleCollection]reloadData];
}

@end
