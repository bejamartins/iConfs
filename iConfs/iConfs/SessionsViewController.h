//
//  SessionsViewController.h
//  iConfs
//
//  Created by Ana T on 24/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *sessionsTable;
@property (strong, nonatomic) IBOutlet UITableView *AuthorsTable;
@property (strong, nonatomic) IBOutlet UILabel *abstract;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) UIButton *ConferenceHome;
@property (strong, nonatomic) UIButton *MenuButton;

@property UIViewController *previous;

@property (strong, nonatomic) UIButton *HomeButton;

- (IBAction)openPaper:(id)sender;
-(void)changeSession:(int)indexSession;
-(void)auxChangeSuperSession:(int)index;

@end
