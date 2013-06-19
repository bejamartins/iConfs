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
#import "IConfs.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@implementation newConferenceContainer{
    NSString *name;
    ConferenceScreenViewController *conference;
    
}
@synthesize collection,myConfs;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


//confPeople = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getSpeakers];


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.collection.dataSource=self;
    self.collection.delegate=self;
    //[[self.collection]setDataSource: self];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];
    self.collection.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"6.jpg"]];
    
    
    
   // conferencesLogos= [[NSArray alloc]initWithObjects:@"inforum.jpg", @"musepat.jpg", @"conf.jpg",nil];
    
   // conferencesNames=[[NSArray alloc]initWithObjects:@"INFORUM",@"MUSEPAT",@"RANDOM", nil];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [myConfs count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"conferenceCell";
    
    
    
    CellMyConferences *cell= [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
   
    Conference *conf=[myConfs objectAtIndex:indexPath.item];
    
    
      UIImage *logo=[conf getLogo];
    
    // NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    //
    // UIImage *image=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :imagePath];
    
    //  [self.bpContainer changeBlueprint: image];
    
    [[cell conferenceLogo]setImage:logo];
    
    
    [[cell conferenceLabel]setText:[conf getName]];
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
    //mudar selectedConf!!!
    //confPeople =
    
       Conference *c=[myConfs objectAtIndex:indexPath.item];
    
    [(MenuViewController*)[[self slidingViewController] underLeftViewController] setSelectedConf:c];

    NSLog(@"Valor de selectedConference =%@",[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf]);
        NSLog(@"Valor de c =%@",c);
    
    //[[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Conference"]];
    NSString *iD = @"Conference";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
    
 //   [[self MenuView] reloadData];
  //  [[[self MenuView] cellForRowAtIndexPath:indexPath] setHighlighted:YES];



    
    
}



@end
