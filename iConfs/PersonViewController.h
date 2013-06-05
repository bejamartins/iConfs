//
//  PersonViewController.h
//  iConfs
//
//  Created by Ana T on 04/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

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
@property (strong, nonatomic) IBOutlet UINavigationItem *navigationBar;

@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (strong, nonatomic) IBOutlet UILabel *biography;
@property (strong, nonatomic) IBOutlet UIButton *session_where;
@property (strong, nonatomic) IBOutlet UILabel *session_when;
@property (strong, nonatomic) IBOutlet UILabel *session_theme;
@property NSInteger IndexAux;
@property NSInteger showPerson;



@end
