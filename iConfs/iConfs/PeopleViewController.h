//
//  PeopleViewController.h
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *PeopleCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Options;
@property (weak, nonatomic) IBOutlet UISearchBar *Search;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;
@property (strong, nonatomic) UIButton *MenuButton;

- (IBAction)selectedOption:(id)sender;

@end
