//
//  BluePrintsViewController.m
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "BluePrintsViewController.h"
#import "FloorCell.h"
#import "WC.h"
#import "Blueprints.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface BluePrintsViewController (){

  //  NSMutableDictionary *bps;
}

@end

@implementation BluePrintsViewController{

    NSMutableArray *searchPlaces;
    
}

@synthesize MenuButton;


- (void)viewDidLoad
{
    
    self.blueprints= [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getBlueprints];
    NSLog(@"Tamanho bps=%d",[self.blueprints count]);
    
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

    [super viewDidLoad];
   [ self.collection setDataSource:self];
   [ self.collection setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection datasource and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self.blueprints count];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
//    NSArray *keys = [self.blueprints allKeys];
//    id aKey = [keys objectAtIndex:indexPath.item];
//    id anObject = [self.blueprints objectForKey:aKey];
//    
//    if ([anObject isKindOfClass:[WC class]]){
    
        static NSString *CellIdentifier=@"floor";
    
    
        FloorCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSArray *keys = [self.blueprints allKeys];
        Blueprints *bp = [keys objectAtIndex:indexPath.item];
    
        NSString *imagePath=[bp getImagePath];
        UIImage *graphImage = [[UIImage alloc] initWithContentsOfFile: imagePath];
    
        [[cell picture]setImage:graphImage];
        
        [[cell floorName]setText:[bp getTitle]];
        
        return cell;
    
 
}

-(void) changeBlueprints:(NSMutableDictionary *)blueprints{
    self.blueprints=blueprints;
}
-(void) refresh{
    [self viewDidLoad];
    //TODO: mandar refrescar o container planta e o container places
}
- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}


@end
