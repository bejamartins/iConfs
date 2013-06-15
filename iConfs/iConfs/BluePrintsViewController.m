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
@interface BluePrintsViewController ()

@end

@implementation BluePrintsViewController{

    NSMutableArray *searchPlaces;
    
}



- (void)viewDidLoad
{
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

@end
