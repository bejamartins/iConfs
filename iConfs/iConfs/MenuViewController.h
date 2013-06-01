//
//  MenuViewController.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MenuView;

@end
