//
//  PeopleCell.h
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *Company;
@property (weak, nonatomic) IBOutlet UIButton *MoreInfoButton;

- (IBAction)moreInfo:(id)sender;
@end
