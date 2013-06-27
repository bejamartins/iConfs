//
//  MenuViewController.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IConfs.h"

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) Conference *selectedConf;

@property (weak, nonatomic) IBOutlet UITableView *MenuView;



- (IBAction)homeButtonPressed:(id)sender;

- (IConfs*) appData;

- (NSArray*)getMySuperSessions:(NSString*)iD;

- (NSArray*)getOtherSuperSessions:(NSString*)iD;

@end
