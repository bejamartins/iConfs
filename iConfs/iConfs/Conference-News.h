//
//  Conference-News.h
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Conference_News : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *picture;

@property (strong, nonatomic) IBOutlet UILabel *title;
- (IBAction)changeNews:(UIPageControl *)sender;

@end
