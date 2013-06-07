//
//  Conference-News.m
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "Conference-News.h"
#import "CellNewsInsideConference.h"

@interface Conference_News ()

@end

@implementation Conference_News

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collection.dataSource=self;
    self.collection.delegate=self;
    //[[self.collection]setDataSource: self];
  //  self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];
  //  self.collection.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];
    
    
    
   // conferencesLogos= [[NSArray alloc]initWithObjects:@"inforum.jpg", @"musepat.jpg", @"conf.jpg",nil];
    
   // conferencesNames=[[NSArray alloc]initWithObjects:@"INFORUM",@"MUSEPAT",@"RANDOM", nil];



}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"newsCell";
    
    
    
    CellNewsInsideConference *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell picture]setImage:[UIImage imageNamed:@"conf.jpg"]];
    
    [[cell title]setText:@"First"];
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    CellMyConferences *cell= (CellMyConferences *)[collection cellForItemAtIndexPath:indexPath];
//    UILabel *label = cell.conferenceLabel;
//    name= label.text;
//    [conference changeName: name];
//    NSLog(@"Entrei no método da célula");
//    NSLog(@"Name= %@", name);
//    NSLog(@"Name Em Conference (did....)= %@", conference.conferenceName);
    
}



@end
