//
//  ManageViewController.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *ConfsCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Options;
@property (weak, nonatomic) IBOutlet UIButton *AddConfButton;
@property (weak, nonatomic) IBOutlet UIButton *RemConfButton;

- (IBAction)addConfs:(id)sender;
- (IBAction)remConfs:(id)sender;
@end
