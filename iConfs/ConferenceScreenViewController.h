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

-(void)changeName:(NSString *)name;

@end

