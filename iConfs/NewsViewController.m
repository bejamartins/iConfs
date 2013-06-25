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
    NSMutableArray *news;
    IConfs *ic;
    NSArray *myConfs;
    NSMutableArray *arrayOfArrays;
    IBOutlet UICollectionView *collection;
}

@end

@implementation NewsViewController
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
    ic=[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    myConfs=[ic getMyConferences];
    
    [collection setDataSource:self];
    [collection setDelegate:self];
    
    
    
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
    [self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
    [MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:MenuButton];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
//    [[cell conferenceName]setText:[]];
    [[cell picture]setImage:[UIImage imageNamed:@"conf.jpg"]];
    
    
    return cell;

}

- (IBAction)segmentedChanged:(id)sender {
    
    if ([[self segmentedControl] selectedSegmentIndex] == 0) {
        news=[[NSMutableArray alloc]init];
        
}
    else{
        news=[[NSMutableArray alloc]init];
        for(Conference *conference in myConfs){
        news=[news arrayByAddingObjectsFromArray:[conference getNews]];
        }
    }
    [collection reloadData];


}
@end
