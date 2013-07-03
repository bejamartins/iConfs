//
//  PeopleViewController.h
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *PeopleCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *Options;
@property (weak, nonatomic) IBOutlet UISearchBar *Search;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;
@property (strong, nonatomic) UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *personNameBar;
@property (strong, nonatomic) IBOutlet UIImageView *iConfsImage;

@property (strong, nonatomic) IBOutlet UILabel *noSelectionLabel;
@property (strong, nonatomic) IBOutlet UITableView *peopleTable;
- (IBAction)selectedOption:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *BIO;
@property (strong, nonatomic) IBOutlet UILabel *speakerBio;
@property (strong, nonatomic) UIButton *ConferenceHome;
@property UIViewController *previous;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) UIButton *BackButton;

@property (strong, nonatomic) UIButton *HomeButton;
- (void)changePrevious:(UIViewController*)vc;
-(void)changeAuthor:(int)index;


@end
