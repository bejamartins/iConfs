//
//  ManageViewController.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IConfs.h"

@interface ManageViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *ConfsCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Options;
@property (weak, nonatomic) IBOutlet UIButton *AddConfButton;
@property (weak, nonatomic) IBOutlet UIButton *RemConfButton;
@property (strong, nonatomic) UIButton *MenuButton;
@property (strong, nonatomic) UIButton *HomeButton;


- (IBAction)addConfs:(id)sender;
- (IBAction)remConfs:(id)sender;
- (IConfs*) appData;

@end
