//
//  PlacesContainerViewController.m
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PlacesContainerViewController.h"
#import "PlaceDefaultCell.h"
#import "PlaceRoomCell.h"
#import "WC.h"
#import "EatingArea.h"
#import "Room.h"
#import "Place.h"
#import "BluePrintsViewController.h"

@interface PlacesContainerViewController (){

    NSMutableArray *allPlaces;
}



@end

@implementation PlacesContainerViewController
@synthesize eat,otherPlaces,wcs,rooms,collection;

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
    
    allPlaces=[[NSMutableArray alloc] init]; 
    
    [self.collection setDataSource:self];

    [self.collection setDelegate:self];
    [allPlaces addObjectsFromArray:wcs];
    [allPlaces addObjectsFromArray:eat];
 //   [allPlaces addObjectsFromArray:otherPlaces];
    [allPlaces addObjectsFromArray:rooms];
  //  NSLog(@"Tamanho do array wcs=%d",[wcs count]);
//    NSLog(@"Tamanho do array other=%d",[otherPlaces count]);
 //   NSLog(@"Tamanho do array eat=%d",[eat count]);
  //  NSLog(@"Tamanho do array rooms=%d",[rooms count]);


    [self.collection reloadData];

    
  //  NSLog(@"Tamanho do array allPlaces=%d",[allPlaces count]);
    
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
  static NSString *CellIdentifier=@"default_place";
    UIImage *picture;
    PlaceDefaultCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    NSLog(@"Item: %d", indexPath.item);

    if(indexPath.row==0){
        [[cell picture]setImage:[UIImage imageNamed:@"clip_art_food.gif"]];
        
                [[cell name]setText:@"Eating Spot"];

    }
    if(indexPath.row==1){
        [[cell picture]setImage:[UIImage imageNamed:@"Bathroom-gender-sign.png"]];
        
        [[cell name]setText:@"WC"];

    }
    else if(indexPath.item==2){
        [[cell picture]setImage:[UIImage imageNamed:@"pulpito.png"]];
        
        [[cell name]setText:@"Rooms"];
  
    
    }
    return cell;
}
//    Place *place=(Place*)[allPlaces objectAtIndex:indexPath.item];
//    static NSString *CellIdentifier;
//    // PlaceRoomCell room_place
//    //PlaceDefaultCell default_place
//  
//    // NSString *path=[place getLogo];
//    BluePrintsViewController *bp=(BluePrintsViewController*)[self parentViewController];
// //   UIImage *picture=[bp returnImagePath:path];
//    UIImage *picture=[UIImage imageNamed:@"1.jpg"];
//    
//    
//    
//    
//    if ([place isKindOfClass:[WC class]]){
//    CellIdentifier=@"default_place";
//      PlaceDefaultCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//        [[cell picture]setImage:[UIImage imageNamed:@"Bathroom-gender-sign.png"]];
//
//        [[cell name]setText:@"WC"];
//        
//        return cell;
//
//        
//
//        
//    }
//    else if ([place isKindOfClass:[EatingArea class]]){
//        CellIdentifier=@"default_place";
//        
//          PlaceDefaultCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//        [[cell picture]setImage:[UIImage imageNamed:@"Bathroom-gender-sign.png"]];
//        [[cell name]setText:@"Eating Spot"];//[place getName]];
//        [[cell picture]setImage:[UIImage imageNamed:@"clip_art_food.gif"]];
//
//
//        return cell;
//
//    }
//    else if([place isKindOfClass:[Room class]]){
//        CellIdentifier=@"default_place";
//        
//        PlaceRoomCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//        //mudar fundo!
//        
//        [[cell picture]setImage:picture];
//   //     [[cell spaceName]setText:[place getName]];
//
//
//        return cell;
//    
//    }
////    else {
////        
////        CellIdentifier=@"room_place";
////        
////        PlaceRoomCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
////        
////        [[cell picture]setImage:picture];
////   //     [[cell spaceName]setText:[place getName]];
////
////        NSString *placeName=[place getName];
////        return cell;
////
////    }
//
//
//    
//  
//
//}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}
//+(void) doLoginWithUserId: (NSString *) userId andPassword : (NSString *) pwd;



-(void)changeEat:(NSArray *)e{
    eat=e;

}

-(void)changeWC:(NSArray*)w{
    wcs=w;

}
-(void)changeRooms:(NSArray*)r{
    rooms=r;
    
}


@end
