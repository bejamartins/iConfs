//
//  HomeViewController.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIPopoverControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionOne;


@end
