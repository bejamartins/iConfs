//
//  CollectionPeopleInSession.m
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "CollectionPeopleInSession.h"
#import "peopleInSessionCell.h"
#import "Person.h"
@interface CollectionPeopleInSession (){
#pragma mark - dados ficticios!

    NSString *authorName;
    NSString *speakerName;
    UIImage *authorPicture;
    UIImage *speakerPicture;
    NSString *authorInstitution;
    NSString *speakerInstitution;

}

@end

@implementation CollectionPeopleInSession


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collection.delegate=self;
    self.collection.dataSource=self;

#pragma mark - dados ficticios!

    authorName=@"Meu Nome de Autor";
    authorInstitution=@"Minha instituição de Autor";
    authorPicture=[UIImage imageNamed:@"author.jpg"];
    
    speakerName=@"Meu Nome de Orador";
    speakerInstitution=@"Minha instituição de Orador";
    speakerPicture=[UIImage imageNamed:@"speaker.jpg"];

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   // return authorsInSession.count + speakersInSession.count;
    return 2;


}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    peopleInSessionCell *cell;
    static NSString *CellIdentifier;
    
    
    //if(indexPath.item<authorsInSession.count){
    if(indexPath.item==0){
        CellIdentifier=@"author_Cell";

         cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//        Person *p=(*Person) [[authorsInSession objectAtIndex:indexPath.item]];
//       UIImage pic = 
//        [[[cell picture]setImage:[p getImagePath ];
        
        [[cell picture]setImage:authorPicture];
        [[cell name]setText:authorName];
        [[cell institution]setText:authorInstitution];
        
//    
    
#pragma mark - dados ficticios!
        
        
    }
    else{
        
        CellIdentifier=@"speaker_cell";
        
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        [[cell picture]setImage:speakerPicture];
        [[cell name]setText:speakerName];
        [[cell institution]setText:speakerInstitution];
    }
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
