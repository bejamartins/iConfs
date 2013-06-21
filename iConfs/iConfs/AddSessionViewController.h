//
//  AddSessionViewController.h
//  iConfs
//
//  Created by Jareth on 6/20/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conference.h"
#import "MAWeekView.h"

@interface AddSessionViewController : UIViewController<MAWeekViewDataSource, MAWeekViewDelegate>

@property Conference *conf;

@property (weak, nonatomic) IBOutlet MAWeekView *AgendaView;

@end
