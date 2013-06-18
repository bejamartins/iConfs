//
//  PlacesContainerViewController.h
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlacesContainerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property NSArray *otherPlaces;
@property NSArray *wcs;
@property NSArray *eat;
@property NSArray *rooms;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
//
-(void)changeEat:(NSArray *)e;
-(void)changeWC:(NSArray*)w;
-(void)changeRooms:(NSArray*)r;
-(void)changeOtherPlaces:(NSArray*)o;

@end
