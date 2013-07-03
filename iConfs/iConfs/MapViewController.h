//
//  MapViewController.h
//  iConfs
//
//  Created by Ian on 6/19/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (strong, nonatomic) UIButton *MenuButton;
@property (strong, nonatomic) UIButton *HomeButton;
@property (strong, nonatomic) UIButton *BackButton;
@property (strong, nonatomic) UIButton *ConferenceHome;

@property UIViewController *previous;



- (void)changePrevious:(UIViewController*)vc;

@end
