//
//  BlueprintContainerViewController.h
//  iConfs
//
//  Created by Ana T on 13/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blueprints.h"
@interface BlueprintContainerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *blueprint;

@property BOOL search;
@property NSArray *placesToShow;

@end
