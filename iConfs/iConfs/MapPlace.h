//
//  MapPlace.h
//  testConection
//
//  Created by Ian on 6/16/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MapPlace : NSObject <MKAnnotation> {
    @protected
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}

@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* subtitle;

-(MapPlace*) initWithData: (CLLocationCoordinate2D)coords :(NSString*)name :(NSString*)address;

-(CLLocationCoordinate2D)getCoord;
-(NSString*)getTitle;
-(NSString*)getSubtitle;

@end
