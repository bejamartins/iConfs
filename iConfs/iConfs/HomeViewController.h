//
//  HomeViewController.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAWeekView.h"

@interface HomeViewController : UIViewController<UIPopoverControllerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, MAWeekViewDataSource, MAWeekViewDelegate>

@property (nonatomic) NSArray* Events;

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionOne;

@property (strong, nonatomic) UIButton *HomeButton;
@property (strong, nonatomic) UIButton *MenuButton;

@property (strong, nonatomic) IBOutlet UILabel *noNewsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *noNewsPicture;
@property (strong, nonatomic) IBOutlet UIImageView *noConferencesPicture;
@property (strong, nonatomic) IBOutlet UILabel *noConferencesLabel;

@end
