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
    NSInteger showPeople;
}


@end

@implementation PeopleC2{
    NSArray *imageArray;
    NSArray *companyArray;
    NSArray *speakers;
    NSArray *authors;
    NSArray *organization;

    IBOutlet UINavigationItem *realBar;
    IBOutlet UINavigationItem *bar;
    IBOutlet UIBarButtonItem *segmentControl;
    
}
@synthesize peopleCollection,segment;

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
    [realBar setTitle:@"Speakers"];

    [[self peopleCollection]setDelegate:self];
    [[self peopleCollection]setDataSource:self];
    imageArray = [[NSArray alloc]initWithObjects:@"speaker.jpg", @"author.jpg", @"conf.jpg",nil];
    speakers = [[NSArray alloc]initWithObjects:@"Speaker 1",@"Speaker 2",@"Speaker 3", nil];
    authors = [[NSArray alloc]initWithObjects:@"Author 1",@"Author 2",@"Author 3", nil];
    organization = [[NSArray alloc]initWithObjects:@"Person 1",@"Person 2",@"Person 3", nil];


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
    [[cell picture]setImage:[UIImage imageNamed:[imageArray objectAtIndex:showPeople]]];

    if (showPeople==0) {
        [[cell name]setText:[speakers objectAtIndex:indexPath.item]];
        [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];
    }
    else if (showPeople==1){
        [[cell name]setText:[authors objectAtIndex:indexPath.item]];
        [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];
    }
    else{
        [[cell name]setText:[organization objectAtIndex:indexPath.item]];
        [[cell company]setText:[companyArray objectAtIndex:indexPath.item]];

    }
   


    
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
    targetVC.showPerson=showPeople;
}

- (IBAction)segmentedChanged:(id)sender {
    
    showPeople= [[self segment] selectedSegmentIndex];
    [self.peopleCollection reloadData];
    NSString *title;
    if(showPeople==0){
    title=@"Speakers";}
    else if (showPeople==1){
    title=@"Authors";
    }
    else{title=@"Organization";}
    
    [realBar setTitle:title];
    }


@end
