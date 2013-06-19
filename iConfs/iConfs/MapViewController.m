//
//  MapViewController.m
//  iConfs
//
//  Created by Ian on 6/19/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "MapViewController.h"
#import "MapPlace.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    
    
    
    //TODO mudar estes valores especificos para os concretos do mapa
    //que está na conferencia, sendo eles:
    //LATITUDE
    //LONGITUDE
    //PLACENAME
    //ADDRESS
    [self doMap:38.661 :-9.2035 :@"Conference X" :@"In the middle of DI FCT!"];
    
    
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






@end
