//
//  ConferenceScreenViewController.h
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConferenceScreenViewController : UIViewController

@property NSString *conferenceName;

@property UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UINavigationItem *bar;

-(void)changeName:(NSString *)name;

@property (strong, nonatomic) IBOutlet UILabel *notification_number;
@property (strong, nonatomic) IBOutlet UILabel *Notification_text;
@property (strong, nonatomic) IBOutlet UILabel *notification_title;
@property (strong, nonatomic) IBOutlet UILabel *date;

@end

