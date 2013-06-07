//
//  PeopleC2.m
//  iConfs
//
//  Created by Ana T on 05/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PeopleC2.h"
#import "Teste.h"
#import "PersonViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface PeopleC2 (){
    NSInteger item;
    NSInteger showPeople;
    NSMutableArray *imageSearchArray;
    NSMutableArray *nameSearchArray;
    NSMutableArray *companySearchArray;
    BOOL searchItem;
}


@end

@implementation PeopleC2{
    NSArray *imageArray;
    NSArray *companyArray;
    NSArray *speakers;
    NSArray *authors;
    NSArray *organization;

    IBOutlet UINavigationItem *realBar;
    IBOutlet UINavigationItem *bar;
    IBOutlet UIBarButtonItem *segmentControl;
    
}
@synthesize peopleCollection,segment;
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
    [realBar setTitle:@"Speakers"];

    [[self peopleCollection]setDelegate:self];
    [[self peopleCollection]setDataSource:self];
    imageArray = [[NSArray alloc]initWithObjects:@"speaker.jpg", @"author.jpg", @"conf.jpg",nil];
    speakers = [[NSArray alloc]initWithObjects:@"Speaker 1",@"Speaker 2",@"Speaker 3", nil];
    authors = [[NSArray alloc]initWithObjects:@"Author 1",@"Author 2",@"Author 3", nil];
    organization = [[NSArray alloc]initWithObjects:@"Person 1",@"Person 2",@"Person 3", nil];


    companyArray = [[NSArray alloc]initWithObjects:@"FCT",@"UNL",@"DI - FCT", nil];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
    //ERRO!
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imageArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    
    Teste *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell picture]setImage:[UIImage imageNamed:[imageArray objectAtIndex:showPeople]]];

    if (showPeople==0) {
        [[cell name]setText:[speakers objectAtIndex:indexPath.item]];
        [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];
    }
    else if (showPeople==1){
        [[cell name]setText:[authors objectAtIndex:indexPath.item]];
        [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];
    }
    else{
        [[cell name]setText:[organization objectAtIndex:indexPath.item]];
        [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];

    }
   


    
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Entrei no método da célula");
    item=indexPath.item;
    [self performSegueWithIdentifier:@"toPerson" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"PREPAREEE");

    PersonViewController *targetVC = (PersonViewController *)segue.destinationViewController;
    
    targetVC.IndexAux=item;//if to set any public variable for example image for the imageview
    targetVC.showPerson=showPeople;
}

- (IBAction)segmentedChanged:(id)sender {
    
    showPeople= [[self segment] selectedSegmentIndex];
    [self.peopleCollection reloadData];
    NSString *title;
    if(showPeople==0){
    title=@"Speakers";}
    else if (showPeople==1){
    title=@"Authors";
    }
    else{title=@"Organization";}
    
    [realBar setTitle:title];
    }

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

@end
