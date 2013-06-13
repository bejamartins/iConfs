//
//  SessionViewController.h
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "Session.h"

@interface SessionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *abstract;
- (IBAction)showInPlant:(id)sender;
- (IBAction)addToAgenda:(id)sender;
-(void) changeSession:(Session *)givenSession;

@property (strong, nonatomic) IBOutlet UILabel *sessionName;
@property (strong, nonatomic) IBOutlet UILabel *sessionWhen;
@property (strong, nonatomic) IBOutlet UILabel *sessionWhere;
@property (strong, nonatomic) IBOutlet UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;

@property Session *Session;

@end
