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
#import "PlaceDefaultCell.h"
@interface BluePrintsViewController (){

    IBOutlet UICollectionView *placeCollection;
    IBOutlet UIImageView *thirdArrow;
    IBOutlet UIImageView *secondArrow;
    IBOutlet UIImageView *firstArrow;
    IBOutlet UILabel *placeLabel;
    int selectedFloor;
    int selectedPlaceType;
    
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
    selectedFloor=0;
    selectedPlaceType=2;
    [placeCollection setDelegate:self];
    [placeCollection setDataSource:self];
    [placesTable setDelegate:self];
    [placesTable setDataSource:self];
    c=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] ;
    
    
    
    self.blueprints= [c getBlueprints];

    NSArray *x=[self.blueprints allValues];

    
    if (selectedBlueprint==nil) {
        
//        NSArray *keys = [self.blueprints allKeys];
//        id aKey = [keys objectAtIndex:0];
//        id anObject = [self.blueprints objectForKey:aKey];
//        selectedBlueprint=anObject;
   
        selectedBlueprint =[x objectAtIndex:0];
        places=[selectedBlueprint getRooms];
        [self changePlacesToShow:places];
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
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"GB.jpg"]];
    self.view.backgroundColor = background;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection datasource and delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
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
    if(collectionView.tag==0)
    return [self.blueprints count];
    else     return 3;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
//    NSArray *keys = [self.blueprints allKeys];
//    id aKey = [keys objectAtIndex:indexPath.item];
//    id anObject = [self.blueprints objectForKey:aKey];
//    
//    if ([anObject isKindOfClass:[WC class]]){
    if(collectionView.tag==0){
        static NSString *CellIdentifier;
        if(selectedFloor!=indexPath.item){
        CellIdentifier=@"floor";
        }
        else{CellIdentifier=@"selected_floor";}
    
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
    else{
        
        static NSString *CellIdentifier;
        if(indexPath.item!=selectedPlaceType){
            CellIdentifier=@"default_place";
        }
        
        else{
            CellIdentifier=@"selected_cell";
            if(selectedPlaceType==0){
                [placeLabel setText:@"Eating Spots"];
            }
            else if(selectedPlaceType==1){
                [placeLabel setText:@"WC"];
            }
            else{
                [placeLabel setText:@"Rooms"];
            }

        
        }
        UIImage *picture;
        PlaceDefaultCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if(indexPath.item==0){
            
        
            [[cell picture]setImage:[UIImage imageNamed:@"clip_art_food.gif"]];
            
            [[cell name]setText:@"Eating Spots"];
            
        }
        if(indexPath.item==1){
                      [[cell picture]setImage:[UIImage imageNamed:@"Bathroom-gender-sign.png"]];
            
            [[cell name]setText:@"WC"];
            
        }
        else if(indexPath.item==2){
            [[cell picture]setImage:[UIImage imageNamed:@"pulpito.png"]];
            
            [[cell name]setText:@"Rooms"];
            
        }
        return cell;
    
    
    
    
    
    }
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *aux= [[NSArray alloc]initWithObjects:[places objectAtIndex:indexPath.row], nil ];
    [self changePlacesToShow:aux];
    
    
    

//por no view did load da coleçao de tipo de colecçao
    
    
//    if(indexPath.row==0){
//        places=[selectedBlueprint getEatingAreas];
//        
//    }
//    else if(indexPath.row ==1){
//        places=[selectedBlueprint getWCs];
//        
//    }
//    else{
//        places=[selectedBlueprint getRooms];
//    }


}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(collectionView.tag==0){
    
    //no array de blueprints vai buscar o com index indexPath.item e depois
    //tem de reflectir essa escolha na planta mostrada ao user.
    
    NSArray *keys = [self.blueprints allKeys];
    id aKey = [keys objectAtIndex:indexPath.item];
    Blueprints *b = [self.blueprints objectForKey:aKey];
    selectedBlueprint=b;
    
    [self changeSelectedBlueprint:b];
    
    [placesTable reloadData];
        selectedFloor=indexPath.item;
            [placesTable deselectRowAtIndexPath:[placesTable indexPathForSelectedRow]animated:YES];
  
        selectedPlaceType=2;
        
        //      NSIndexPath *selection = [NSIndexPath indexPathForItem:2 inSection:0];
   //     [placeCollection selectItemAtIndexPath:selection animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
        
        
        [placeCollection reloadData];
        
        
  
    }


    
    else{
            if(indexPath.item==0){
                places=[selectedBlueprint getEatingAreas];
        
            }
            else if(indexPath.item ==1){
                places=[selectedBlueprint getWCs];
        
            }
           else{
            places=[selectedBlueprint getRooms];
           }
        [self changePlacesToShow:places];
        selectedPlaceType=indexPath.item;
    }
     //   NSLog(@"Detectei toque");
    
    [collectionView reloadData];
    [placesTable reloadData];
  
    
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
    //        [bpController changePlaces: places];
        //    [bpController viewDidLoad];
            

            
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
    
}
-(void)changeSelectedBlueprint:(Blueprints*)newBlueprint{
    selectedBlueprint=newBlueprint;
    places=[selectedBlueprint getRooms ];
    [self changePlacesToShow:places];
    NSString *imagePath=[selectedBlueprint getImagePath];

    NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    //
    UIImage *image=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :imagePath];
    
   
    NSArray *childViewControllers =[self childViewControllers];
    int counter=(int)[childViewControllers count];
    for (int i=0;i<counter;i++){
    
        
        UIViewController *childViewController=[childViewControllers objectAtIndex:i];

        
                 if([childViewController isKindOfClass:[BlueprintContainerViewController class]]){
        
            //found container view controller
            BlueprintContainerViewController *bpController = (BlueprintContainerViewController *)childViewController;
            
            //image=[UIImage imageNamed:@"1.jpg"];
            bpController.image=image;
            [bpController changeBlueprint:image];
            
            
                }

    }

}

-(void)changePlacesToShow:(NSArray*)pl{
    
    NSArray *childViewControllers =[self childViewControllers];

    for (int i=0;i<[childViewControllers count];i++){
        
        
        UIViewController *childViewController=[childViewControllers objectAtIndex:i];

     if([childViewController isKindOfClass:[BlueprintContainerViewController class]]){
        
        //found container view controller
        BlueprintContainerViewController *bpController = (BlueprintContainerViewController *)childViewController;
        
        //image=[UIImage imageNamed:@"1.jpg"];
        [bpController changePlaces:pl];
        
        
    }
    
        }
}

-(UIImage*) returnImagePath:(NSString*)imagePath{
    
    
    NSString *aux=[self.c getID];
    
    
    UIImage *image=[self.c loadImage:aux :imagePath];

    return image;
}

@end
