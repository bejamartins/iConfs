//
//  AgendaViewController.h
//  iConfs
//
//  Created by Jareth on 6/10/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAWeekView.h"

@class MAEventKitDataSource;

@interface AgendaViewController : UIViewController<MAWeekViewDataSource, MAWeekViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    MAEventKitDataSource *_eventKitDataSource;
}
@property (strong, nonatomic) UIButton *HomeButton;
@property (strong, nonatomic) IBOutlet UIButton *MenuButton;
@property (weak, nonatomic) IBOutlet UIView *AgendaView;

@end
