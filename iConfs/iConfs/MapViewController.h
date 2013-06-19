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

@end
