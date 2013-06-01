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
@interface HomeViewController (){
    NSArray *arrayOfImages;
    NSArray *arrayOfDescriptions;
    //    ConferencesCollection *cc;
    
    
}
@property (strong, nonatomic) IBOutlet UICollectionView *ct;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // [[self.collectionOne] scrollDirection=UICollectionViewScrollDirectionHorizontal];
    self.CollectionOne.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"11.png"]];
    self.CollectionOne.delegate=self;
    self.CollectionOne.dataSource=self;
    // self.ConferenceCollection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"6.png"]];
    
    arrayOfImages= [[NSArray alloc]initWithObjects:@"conf.jpg", @"conf.jpg", @"conf.jpg",nil];
    arrayOfDescriptions=[[NSArray alloc]initWithObjects:@"First",@"Second",@"Third", nil];
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
    return [arrayOfDescriptions count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"cellOne";
    CustomCellOne *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell Image]setImage:[UIImage imageNamed:[arrayOfImages objectAtIndex:indexPath.item]]];
    
    [[cell Description]setText:[arrayOfDescriptions objectAtIndex:indexPath.item]];
    
    return cell;
}

@end