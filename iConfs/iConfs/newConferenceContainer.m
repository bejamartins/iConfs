//
//  newConferenceContainer.m
//  iConfs
//
//  Created by Ana T on 05/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "newConferenceContainer.h"
#import "CellMyConferences.h"
#import "ConferenceScreenViewController.h"


@implementation newConferenceContainer{
    NSString *name;
    ConferenceScreenViewController *conference;
}
@synthesize collection;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collection.dataSource=self;
    self.collection.delegate=self;
    //[[self.collection]setDataSource: self];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];
    self.collection.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];

    
    
    conferencesLogos= [[NSArray alloc]initWithObjects:@"inforum.jpg", @"musepat.jpg", @"conf.jpg",nil];
    
    conferencesNames=[[NSArray alloc]initWithObjects:@"INFORUM",@"MUSEPAT",@"RANDOM", nil];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [conferencesNames count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"cellConference";
    
    
    
    CellMyConferences *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell conferenceLogo]setImage:[UIImage imageNamed:[conferencesLogos objectAtIndex:indexPath.item]]];
    
    [[cell conferenceLabel]setText:[conferencesNames objectAtIndex:indexPath.item]];
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CellMyConferences *cell= (CellMyConferences *)[collection cellForItemAtIndexPath:indexPath];
    UILabel *label = cell.conferenceLabel;
    name= label.text;
    [conference changeName: name];
    NSLog(@"Entrei no método da célula");
    NSLog(@"Name= %@", name);
    NSLog(@"Name Em Conference (did....)= %@", conference.conferenceName);

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Entrei no método do segue");
    
    // UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"toConference"]) {
        // NSIndexPath *a= [sender indexPath];
        //   personView.IndexAux=a.item ;
         conference=segue.destinationViewController;
        
        NSLog(@"VOU MUDAR O NOME NO PREPARE!");

        [conference changeName: name];
        NSLog(@"Name Segue= %@", conference.conferenceName);

    }
}


@end
