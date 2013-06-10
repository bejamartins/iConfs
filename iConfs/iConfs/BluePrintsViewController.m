//
//  BluePrintsViewController.m
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "BluePrintsViewController.h"
#import "FloorCell.h"
@interface BluePrintsViewController ()

@end

@implementation BluePrintsViewController



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
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"floor";
    FloorCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell picture]setImage:[UIImage imageNamed:@"speaker.jpg"]];
    
    [[cell floorName]setText:@"floor"];
    
    return cell;
}

@end
