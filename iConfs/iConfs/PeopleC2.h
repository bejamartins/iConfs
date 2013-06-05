//
//  PeopleC2.h
//  iConfs
//
//  Created by Ana T on 05/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleC2 : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *peopleCollection;
- (IBAction)segmentedChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;

@end
