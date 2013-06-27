//
//  NewsViewController.m
//  iConfs
//
//  Created by Ana T on 19/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//
#import "NewsCell.h"
#import "NewsViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface NewsViewController (){
    NSArray *news;
    IConfs *ic;
    NSArray *myConfs;
    NSMutableArray *arrayOfArrays;
    BOOL oneNews;
    BOOL inConference;
}

@end

@implementation NewsViewController
@synthesize MenuButton,collection,HomeButton,BackButton,previous,segmentedControl;

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
    
    [collection setDataSource:self];
    [collection setDelegate:self];
    
    if(news==nil){
    ic=[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    myConfs=[ic getMyConferences];
 
    
    news=[[NSMutableArray alloc]init];
    news=[ic getAllNewsOrderedByDate];
        oneNews=NO;
    NSArray* reversedArray = [[news reverseObjectEnumerator] allObjects];
    news=reversedArray;
    
    }
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
    if (!oneNews) {
    
    [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    }
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
    
    
    if(inConference){

  
        
        [self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
        
        [BackButton setFrame:CGRectMake(717, 4, 43, 40)];
        [BackButton setBackgroundImage:[UIImage imageNamed:@"back3.png"] forState:UIControlStateNormal];
        [BackButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self view] addSubview:BackButton];
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (IBAction)goHome:(id)sender{
    
    
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
    
    
}
- (IBAction)goBack:(id)sender{
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:previous];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
}



- (void)changePrevious:(UIViewController*)vc{
    inConference =YES;
    previous=vc;
    
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




#pragma mark - Collection datasource and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [news count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    static NSString *CellIdentifier=@"cell";
    
    
    NewsCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"rounded-rectangle-final.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];

    //cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"rounded-rectangle-final.png"]];

    News *n=[news objectAtIndex:indexPath.item] ;
    
    [[cell text]setText:[n getText]];
    [[cell title]setText:[n getTitle]];
    
    [[cell date] setText:[n getDate]];
    
    NSArray *id=[n getConfID];
    
    Conference *c=[self getConferenceOfNews:n];
    
    [[cell conferenceName]setText:[c getName]];
    [[cell picture]setImage:[c getLogo]];
    
    
    return cell;

}

- (IBAction)segmentedChanged:(id)sender {
    
    if(!oneNews){
    if ([[self segmentedControl] selectedSegmentIndex] == 0) {
        news=[[NSMutableArray alloc]init];
        news=[ic getAllNewsOrderedByDate];
        
        NSArray* reversedArray = [[news reverseObjectEnumerator] allObjects];
        news=reversedArray;

        [collection reloadData];

}
    else{
        news=[[NSArray alloc]init];
        for(Conference *conference in myConfs){
            NSArray *aux=[conference getNews];
            NSArray* reversedArray = [[aux reverseObjectEnumerator] allObjects];

        news=[news arrayByAddingObjectsFromArray:reversedArray];
        }
    }
    [collection reloadData];


}
    

}

-(void)changeNews:(NSArray*)nws{
    news=nws;
    oneNews =YES;
    [segmentedControl setHidden:YES];
    [self viewDidLoad];
    [collection reloadData];
}



-(Conference *) getConferenceOfNews:(News*)n{
    ic=[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    NSArray *ids=[n getConfID];
    NSString *id=[ids objectAtIndex:0];
    Conference* c=[ic getConferenceWithID:id];

    return c;
}
@end
