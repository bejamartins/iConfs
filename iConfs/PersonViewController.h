//
//  PersonViewController.h
//  iConfs
//
//  Created by Ana T on 04/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PersonViewController : UIViewController{
@public
    NSString *name;
    NSInteger index;
    UIImage *passPicture;
    NSArray *imageArray;
    NSArray *nameArray;
    NSArray *companyArray;
    NSArray *biographies;
    NSArray *speakers;
    NSArray *authors;
    NSArray *organization;
}

@property (strong, nonatomic) Person *shownPerson;

@property (strong, nonatomic) UIButton *MenuButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavBar;
@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) IBOutlet UILabel *biography;
@property NSInteger IndexAux;
@property NSInteger showPerson;

@end
