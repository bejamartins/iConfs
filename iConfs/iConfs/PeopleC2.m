//
//  PeopleC2.m
//  iConfs
//
//  Created by Ana T on 05/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PeopleC2.h"
#import "Teste.h"
#import "PersonViewController.h"

@interface PeopleC2 (){
    NSInteger item;
}

    
@end

@implementation PeopleC2{
    NSArray *imageArray;
    NSArray *nameArray;
    NSArray *companyArray;
}

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
    [[self peopleCollection]setDelegate:self];
    [[self peopleCollection]setDataSource:self];
    imageArray = [[NSArray alloc]initWithObjects:@"conf.jpg", @"conf.jpg", @"conf.jpg",nil];
    nameArray = [[NSArray alloc]initWithObjects:@"Person 1",@"Person 2",@"Person 3", nil];
    companyArray = [[NSArray alloc]initWithObjects:@"FCT",@"UNL",@"DI - FCT", nil];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imageArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"Cell";
    Teste *cell=[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
  
    [[cell picture]setImage:[UIImage imageNamed:[imageArray objectAtIndex:indexPath.item]]];
    [[cell name]setText:[nameArray objectAtIndex:indexPath.item]];
    [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];


    
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Entrei no método da célula");
    item=indexPath.item;
    [self performSegueWithIdentifier:@"toPerson" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"PREPAREEE");

    PersonViewController *targetVC = (PersonViewController *)segue.destinationViewController;
    
    targetVC.IndexAux=item;//if to set any public variable for example image for the imageview
}



@end
