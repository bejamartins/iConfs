//
//  HomeViewController.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "HomeViewController.h"
#import "CustomCellOne.h"
#import "CustomCellTwo.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "newConferenceContainer.h"
#import "News.h"
#import "NewsViewController.h"
@interface HomeViewController (){
    NSArray *news;
    NSMutableArray *pictures;
    
    IBOutlet UIButton *moreNewsButton;
}
@property (strong, nonatomic) IBOutlet UICollectionView *ct;
@property (strong, nonatomic) IBOutlet UIButton *agendaPreviewB;

@end

@implementation HomeViewController

@synthesize MenuButton,noConferencesLabel,noConferencesPicture,noNewsLabel,noNewsPicture;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // [[self.collectionOne] scrollDirection=UICollectionViewScrollDirectionHorizontal];
    self.CollectionOne.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"11.png"]];
    self.CollectionOne.delegate=self;
    self.CollectionOne.dataSource=self;
    // self.ConferenceCollection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"6.png"]];
    
    
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
    
    

    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"GB.jpg"]];
    self.view.backgroundColor = background;
    
    


    
    //confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];
    
    //confirmar
 
    IConfs *ic=[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    NSArray *myConfs=[ic getMyConferences];

    
    
    for (UIViewController *childViewController in [self childViewControllers])
    {
        if ([childViewController isKindOfClass:[newConferenceContainer class]])
        {
            //found container view controller
            newConferenceContainer *myCsContainer = (newConferenceContainer *)childViewController;
            
            myCsContainer.myConfs=myConfs;
            [myCsContainer viewDidLoad];
            
        //    //image=[UIImage imageNamed:@"1.jpg"];
          //  bpController.image=image;
           // [bpController changeBlueprint:image];
        }
    
    }
    
    
    news=[[NSMutableArray alloc] init];
    pictures=[[NSMutableArray alloc] init];


    
    
    news=[[NSMutableArray alloc]init];
    news=[ic getAllNewsOrderedByDate];
    
    NSArray* reversedArray = [[news reverseObjectEnumerator] allObjects];
    NSMutableArray *aux=[[NSMutableArray alloc] init];
    int counter;
    if([reversedArray count]>=5)
        counter=5;
    else counter= [reversedArray count];
    
    for (int i=0; i<counter ;i++){
    
        [aux addObject:[reversedArray objectAtIndex:i] ];
        News *n=[reversedArray objectAtIndex:i];
        NSArray *id=[n getConfID];
      Conference *c=  [ic getConferenceWithID:[id objectAtIndex:0]];
        [pictures addObject:[c getLogo]];
    }
    news= [[NSArray alloc] initWithArray:aux];
;
    
       
    if([news count]==0){
    
        [noNewsPicture setHidden:NO];
        [noNewsLabel setHidden:NO];
    }
    
    
    if ([myConfs count]==0) {
        [noConferencesPicture setHidden:NO];
        [noConferencesLabel setHidden:NO];
    }
    
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
    static NSString *CellIdentifier=@"cellOne";
    CustomCellOne *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    News *n= [news objectAtIndex:indexPath.item];
    [[cell Image]setImage:[pictures objectAtIndex:indexPath.item]];
    
    [[cell Description]setText:[n getTitle]];
    
    return cell;
}
- (IBAction)clickMoreNews:(id)sender {
        NSString   *iD = @"News";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
}



//-(void)changeScreenTo:(BOOL)myConfs{
//    NSString *iD;
//
//    if(myConfs){
//       iD = @"Conference";
//
//    
//    }
//    
//    else{
//    
//    }

        
- (IBAction)clickAgendaPreview:(id)sender {
    
    
    NSString *iD = @"Personal Agenda";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
NSString *iD = @"News";

NewsViewController *newTopViewController =[[self storyboard]instantiateViewControllerWithIdentifier:iD];
    int item=indexPath.item;
    
    NSArray *aux=[NSArray arrayWithObject:[news objectAtIndex:indexPath.item]];
    [newTopViewController changeNews:aux];
    [newTopViewController viewDidLoad];

CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
[[self slidingViewController] setTopViewController:newTopViewController];
[[[[self slidingViewController] topViewController] view] setFrame:frame];
    



}




@end