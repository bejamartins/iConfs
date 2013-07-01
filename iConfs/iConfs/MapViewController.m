//
//  MapViewController.m
//  iConfs
//
//  Created by Ian on 6/19/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "MapViewController.h"
#import "MapPlace.h"

#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "Conference.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize MenuButton,HomeButton,BackButton;

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    [self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
    [MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:MenuButton];
    
    [self setHomeButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [HomeButton setFrame:CGRectMake(45, 0, 43, 40)];
    [HomeButton setBackgroundImage:[UIImage imageNamed:@"white_home.png"] forState:UIControlStateNormal];
    [HomeButton addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:HomeButton];
    
    
    
    
    Map* map= [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getMap];
    
    
    if(map!= NULL){
        //TODO mudar estes valores especificos para os concretos do mapa
        //que está na conferencia, sendo eles:
        //LATITUDE
        //LONGITUDE
        //PLACENAME
        //ADDRESS
        //[self doMap:38.661 :-9.2035 :@"Conference X" :@"In the middle of DI FCT!"];
        [self doMap:map.getLat :map.getLong :map.getPlaceName :map.getAddress];
    }
    else{
        [self doMap:0 :0 :@"We are sorry" :@"but no map was defined"];
    }
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"GB.jpg"]];
    self.view.backgroundColor = background;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(void)doMap:(float)lat :(float)lng :(NSString*)name :(NSString*)address{
    
    //  MKMapView* map = [MKMapView new];
    [[self map] setMapType:MKMapTypeStandard];
    [[self map] setZoomEnabled:YES];
    [[self map] setScrollEnabled:YES];
    
    MKCoordinateRegion region={{0.0, 0.0},{0.0, 0.0}};
    region.center.latitude=lat;
    region.center.longitude=lng;
    region.span.latitudeDelta=0.01f;
    region.span.longitudeDelta=0.01f;
    [[self map] setRegion:region animated:YES];
    
    MapPlace *place=[[MapPlace alloc]init];
    place=[place initWithData:region.center :name :address];
    [[self map] addAnnotation:place];
    
}







- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}


- (IBAction)goHome:(id)sender{
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
}
/*
 - (IBAction)goBack:(id)sender{
 CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
 [[self slidingViewController] setTopViewController:previous];
 [[[[self slidingViewController] topViewController] view] setFrame:frame];
 
 }
 - (void)changePrevious:(UIViewController*)vc{
 inConference =YES;
 previous=vc;
 
 }
 */

@end
