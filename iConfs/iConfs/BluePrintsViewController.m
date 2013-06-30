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
#import "PlacesContainerViewController.h"
#import "Conference.h"

@interface BluePrintsViewController (){

    IBOutlet UIImageView *thirdArrow;
    IBOutlet UIImageView *secondArrow;
    IBOutlet UIImageView *firstArrow;
    IBOutlet UILabel *placeLabel;
  //  NSMutableDictionary *bps;
}

@end

@implementation BluePrintsViewController{

    NSMutableArray *searchPlaces;
    Blueprints *selectedBlueprint;
    NSArray *places;
    
    
}

@synthesize MenuButton,placesContainer,bpContainer,c,placesTable;

//mandar para o container o mapa a mostrar!
//mandar para o container os places a mostrar

- (void)viewDidLoad
{
    [placesTable setDelegate:self];
    [placesTable setDataSource:self];
    c=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] ;
    
    self.blueprints= [c getBlueprints];

    NSArray *x=[self.blueprints allValues];
    
    // NSLog(@"Tamanho bps=%d",[self.blueprints count]);
//    NSArray *keys = [self.blueprints allKeys];
 //   id aKey = [keys objectAtIndex:0];
 //   Blueprints *b1 = [self.blueprints objectForKey:aKey];
//    aKey=[keys objectAtIndex:1];
//    Blueprints *b2=[self.blueprints objectForKey:aKey];
    
    if (selectedBlueprint==nil) {
        
//        NSArray *keys = [self.blueprints allKeys];
//        id aKey = [keys objectAtIndex:0];
//        id anObject = [self.blueprints objectForKey:aKey];
//        selectedBlueprint=anObject;
   
        selectedBlueprint =[x objectAtIndex:0];
        places=[selectedBlueprint getEatingAreas];
    
    }
    
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
    
    
    [self changeSelectedBlueprint:selectedBlueprint];
   // [ self sendPlacesToContainer];
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
    return 1;}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [places count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Place* p=[places objectAtIndex:indexPath.row];
    [[cell textLabel]setText:[p getName]];

    return cell;

}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.blueprints count];
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
        NSString *key = [keys objectAtIndex:indexPath.item];
   // NSLog(@"Vou buscar o 1º Mapa! :D item=%d",indexPath.item );
    Blueprints *bp=[self.blueprints objectForKey:key];
   // NSLog(self.blueprints);
        NSString *imagePath=[bp getImagePath];
     //   UIImage *graphImage = [[UIImage alloc] initWithContentsOfFile: imagePath];
    
    
 //   NSLog(@"Path do mapa=%@",imagePath);
    NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    //
        [[cell picture] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :imagePath]];
        
        
        [[cell floorName]setText:[bp getTitle]];
        
        return cell;
    
 
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //no array de blueprints vai buscar o com index indexPath.item e depois
    //tem de reflectir essa escolha na planta mostrada ao user.
    
    NSArray *keys = [self.blueprints allKeys];
    id aKey = [keys objectAtIndex:indexPath.item];
    Blueprints *b = [self.blueprints objectForKey:aKey];
    selectedBlueprint=b;

    [self changeSelectedBlueprint:b];
    
     //   NSLog(@"Detectei toque");
    
    
    
    for (UIViewController *childViewController in [self childViewControllers])
    {
        if ([childViewController isKindOfClass:[BlueprintContainerViewController class]])
        {
            
            
            NSString *imagePath=[selectedBlueprint getImagePath];
            
            NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
            //
            UIImage *image=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :imagePath];

            //found container view controller
            BlueprintContainerViewController *bpController = (BlueprintContainerViewController *)childViewController;
            
            //UIImage *image=[UIImage imageNamed:@"1.jpg"];
            bpController.image=image;
            [bpController changeBlueprint:image];
            
            break;
        }
    }



    
}

-(void) refresh{
    [self viewDidLoad];
    //TODO: mandar refrescar o container planta e o container places
}
- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}
-(void) sendPlacesToContainer{
    NSArray *Otherplaces= [selectedBlueprint getOtherPlaces];
    NSArray *WCs=[selectedBlueprint getWCs];
    NSArray *rooms=[selectedBlueprint getRooms];
    NSArray *eat=[selectedBlueprint getEatingAreas];
    
 //   NSLog(@"Numero otherPlaces=%d",[Otherplaces count]);
  //  NSLog(@"Numero wc=%d",[WCs count]);
  //  NSLog(@"Numero rooms=%d",[rooms count]);
  //  NSLog(@"Numero eat=%d",[eat count]);


    
    
}
-(void)changeSelectedBlueprint:(Blueprints*)newBlueprint{
    selectedBlueprint=newBlueprint;
    NSString *imagePath=[selectedBlueprint getImagePath];

    NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    //
    UIImage *image=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :imagePath];
    
  //  [self.bpContainer changeBlueprint: image];
   
    NSArray *childViewControllers =[self childViewControllers];
    int counter=(int)[childViewControllers count];
    for (int i=0;i<counter;i++){
    
        
        UIViewController *childViewController=[childViewControllers objectAtIndex:i];
        if([ childViewController isKindOfClass:[PlacesContainerViewController class]]){
           // PlacesContainerViewController
        //ir buscar os places do selectedBlueprint
            //chamar metodo no container com os places a mostrar e depois chamar o viewDidLoad
            
            PlacesContainerViewController *pController= (PlacesContainerViewController*) childViewController;
        
            NSArray *places=[selectedBlueprint getEatingAreas];
            [pController changeEat:places];
      //      NSLog(@"tamanho do places %d",[places count]);
           // places=[selectedBlueprint getOtherPlaces];
           // [pController changeOtherPlaces:places];
           // NSLog(@"---tamanho do other %d",[places count]);

            places=[selectedBlueprint getWCs];
            [pController changeWC:places];
   //         NSLog(@"tamanho do wcs %d",[places count]);

            places=[selectedBlueprint getRooms];
            [pController changeRooms:places];
    //        NSLog(@"tamanho do rooms %d",[places count]);

           
            [pController viewDidLoad];
            
            

        }
        
                else if([childViewController isKindOfClass:[BlueprintContainerViewController class]]){
        
            //found container view controller
            BlueprintContainerViewController *bpController = (BlueprintContainerViewController *)childViewController;
            
            //image=[UIImage imageNamed:@"1.jpg"];
            bpController.image=image;
            [bpController changeBlueprint:image];
            
            
                }

    }

}

-(void)changePlacesToShow:(int)type pl:(NSArray*)places{

    
    

}

-(UIImage*) returnImagePath:(NSString*)imagePath{
    
    
    NSString *aux=[self.c getID];
    
    
    UIImage *image=[self.c loadImage:aux :imagePath];

    return image;
}

@end
