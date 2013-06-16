//
//  SessionViewController.m
//  iConfss
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "SessionViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "Session.h"
#import "Event.h"
#import "peopleInSessionCell.h"

@interface SessionViewController (){
    NSInteger numberOfCells;
    
    
    NSString *authorNameR;
    NSString *speakerNameR;
    UIImage *authorPictureR;
    UIImage *speakerPictureR;
    NSString *authorInstitutionR;
    NSString *speakerInstitutionR;
    
    
    
    
    
#pragma mark - dados ficticios!
    
    NSString *authorName;
    NSString *speakerName;
    UIImage *authorPicture;
    UIImage *speakerPicture;
    NSString *authorInstitution;
    NSString *speakerInstitution;
    
    
    
    
    
}

@end

@implementation SessionViewController

@synthesize Session, MenuButton,abstract;

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
    
    self.collection.delegate=self;
    self.collection.dataSource=self;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
    //TODO: por de novo!
    
    //   [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
    
    
    [self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
    [MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [[self view] addSubview:MenuButton];
    
    
    numberOfCells=2;
    if(Session !=nil){
        NSDate *date= [self.Session getDate];
        
        [self.sessionName setText:[self.Session getTitle]];
        
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        [self.sessionWhen setText:dateString];
        
        //TODO: confirmar!
        //  NSString *placeID=[Session getPlaceID];
        
        //TODO: !!!!! Imprimir o lugar onde vai acontecer!!!!
        // [self.sessionWhere];
        
        NSString *theme;
        theme=[self.Session getTheme];
        
        [self.abstract setText:theme];
        
        Author *author= [self.Session getAuthor];
        Speaker *speaker= [self.Session getSpeaker];
        
        
        authorNameR=[author getName];
        NSString *imagePath=[author getImagePath];
        UIImage *graphImage = [[UIImage alloc] initWithContentsOfFile: imagePath];
        authorPicture = graphImage;
        authorInstitutionR=[author getWork];
        
        if ([self.Session getSpeaker] ==nil) {
            numberOfCells=1;
        }
        else{
            speakerInstitutionR=[speaker getWork];
            imagePath= [speaker getImagePath];
            graphImage = [[UIImage alloc] initWithContentsOfFile: imagePath];
            speakerPictureR = graphImage;
            speakerNameR=[speaker getName];
            numberOfCells=2;
        }
    }
    
#pragma mark - retirar: dados ficticios!
    authorName=@"Meu Nome de Autor";
    authorInstitution=@"Minha instituição de Autor";
    authorPicture=[UIImage imageNamed:@"author.jpg"];
    
    speakerName=@"Meu Nome de Orador";
    speakerInstitution=@"Minha instituição de Orador";
    speakerPicture=[UIImage imageNamed:@"speaker.jpg"];
    
    
    // self.abstract=[];
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return numberOfCells;
    
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
    
    //TODO: MANDAR PARA SPEAKER OU AUTHOR
    if(indexPath.item==0){
        NSLog(@"Detectei toque no AUTOR!");
        //mudar interface
        NSString *iD = @"Person";
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        [[self slidingViewController] resetTopView];
        
        
    }
    else{
        NSLog(@"Detectei toque no SPEAKER!");
        NSString *iD = @"Person";
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        [[self slidingViewController] resetTopView];
    }
    
    
    //    CellMyConferences *cell= (CellMyConferences *)[collection cellForItemAtIndexPath:indexPath];
    //    UILabel *label = cell.conferenceLabel;
    //    name= label.text;
    //    [conference changeName: name];
    //    NSLog(@"Entrei no método da célula");
    //    NSLog(@"Name= %@", name);
    //    NSLog(@"Name Em Conference (did....)= %@", conference.conferenceName);
    
}

-(void) changeSession:(Session *)givenSession{
    self.Session=givenSession;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}

- (IBAction)showInPlant:(id)sender {
}

- (IBAction)addToAgenda:(id)sender {
    
}


//mudar interface
//NSString *iD = @"Conference";
//
//UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
//
//CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
//[[self slidingViewController] setTopViewController:newTopViewController];
//[[[[self slidingViewController] topViewController] view] setFrame:frame];
//[[self slidingViewController] resetTopView];

#import "ECSlidingViewController.h"
#import "MenuViewController.h"

//Codigo do menu
//[[[self view] layer] setShadowOpacity:0.75f];
//[[[self view] layer] setShadowRadius:10.0f];
//[[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
//
//if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
//    [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
//}
//
//[[self view] addGestureRecognizer:[self slidingViewController].panGesture];
//
//[self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
//
//[MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
//[MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
//[MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
//
//[[self view] addSubview:MenuButton];

//
//- (IBAction)revealMenu:(id)sender
//{
//    [[self slidingViewController] anchorTopViewTo:ECRight];
//}


//subst por imagens

//NSString* tmpS=[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
//
//if (!searchItem) {
//    [[cell Image] setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:tmpS :[(Person*)[confPeople objectAtIndex:[indexPath row]] getImagePath]]];

@end