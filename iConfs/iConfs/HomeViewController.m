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
@interface HomeViewController (){
    NSMutableArray *news;
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
    
    

    
    
    


    
    //confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];
    
    //confirmar
 
    IConfs *ic=[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
    NSArray *myConfs=[ic getMyConferences];
    
  //  NSString *imagePath=[selectedBlueprint getImagePath];
    
   // NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    //
   // UIImage *image=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :imagePath];
    
    //  [self.bpContainer changeBlueprint: image];
    
    
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


   // IConfs *ic=[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData];
   //NSArray *myConfs=[ic getMyConferences];
    for(int i=0;i<[myConfs count];i++){
     
        
       NSArray *newsAux=[[NSArray alloc] init];

        newsAux=[[myConfs objectAtIndex:i]getNews];
        NSInteger count= [newsAux count];
        
        
        
        //[[[myConfs objectAtIndex:i]getNews ] objectAtIndex:[[[myConfs objectAtIndex:i]getNews ] ]count];
        if(count!=0){
            News *n=[newsAux objectAtIndex:count-1];
            [news addObject:n];
            UIImage *p=[[myConfs objectAtIndex:i]getLogo];
            
            [pictures addObject: p];

        }
        
    
    }
    
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




    




@end