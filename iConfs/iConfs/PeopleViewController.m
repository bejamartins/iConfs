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

@interface PeopleViewController ()
{
    NSArray *imageArray;
    NSArray *nameArray;
    NSArray *companyArray;
    NSMutableArray *imageSearchArray;
    NSMutableArray *nameSearchArray;
    NSMutableArray *companySearchArray;
    BOOL searchItem;
}
@end

@implementation PeopleViewController

@synthesize collection;
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
    
    imageArray = [[NSArray alloc]initWithObjects:@"conf.jpg", @"conf.jpg", @"conf.jpg",nil];
    nameArray = [[NSArray alloc]initWithObjects:@"Person 1",@"Person 2",@"Person 3", nil];
    companyArray = [[NSArray alloc]initWithObjects:@"FCT",@"UNL",@"DI - FCT", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma - Collection View Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!searchItem)
        return [imageArray count];
    else
        return [imageSearchArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    PeopleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!searchItem) {
        [[cell Image]setImage:[UIImage imageNamed:[imageArray objectAtIndex:indexPath.item]]];
        [[cell Name]setText:[nameArray objectAtIndex:indexPath.item]];
        [[cell Company]setText:[companyArray objectAtIndex:indexPath.item]];
    }else {
        [[cell Image]setImage:[UIImage imageNamed:[imageSearchArray objectAtIndex:[indexPath row]]]];
        [[cell Name]setText:[nameSearchArray objectAtIndex:[indexPath row]]];
        [[cell Company]setText:[companySearchArray objectAtIndex:[indexPath row]]];
    }
    
    return cell;
}

#pragma - Search Bar Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        searchItem = NO;
    }else {
        searchItem = YES;
        
        imageSearchArray = [[NSMutableArray alloc]init];
        nameSearchArray = [[NSMutableArray alloc]init];
        companySearchArray = [[NSMutableArray alloc]init];
        
        NSString *str = [[NSString alloc]init];
        
        for (int i = 0; i < [nameArray count]; i++) {
            str = [nameArray objectAtIndex:i];
            
            NSRange stringRange = [str rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (stringRange.location != NSNotFound) {
                [nameSearchArray addObject:str];
                [imageSearchArray addObject:[imageArray objectAtIndex:i]];
                [companySearchArray addObject:[companyArray objectAtIndex:i]];
            }
        }
    }
    
    [[self PeopleCollection]reloadData];
}

- (IBAction)selectedOption:(id)sender {
    [[self PeopleCollection]reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   // UIViewController *destination = segue.destinationViewController;
    PersonViewController *personView=segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"segueFromCell"]) {
      //  NSIndexPath *a= [sender indexPath];
      //  personView.IndexAux=a.item ;
         NSArray *ips = [self.collection indexPathsForSelectedItems];
        NSIndexPath *ip = [ips objectAtIndex:0];
        personView.IndexAux=[ip item];
        //    NSInteger aux= [[sender indexPath] row];
//  personView->passPicture=[imageArray objectAtIndex:1];
 //       personView->name=[nameArray objectAtIndex:1];
   //     personView->index=1;
    }
    
}
- (IBAction)moreInfo:(id)sender {
  
    
    
}

@end
