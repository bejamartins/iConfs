//
//  PeopleCell.h
//  iConfs
//
//  Created by Jareth on 5/30/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"

@interface PeopleCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *Image;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property  int index;
@property  int indexSupersessions;
@property  int indexSession;

-(int)getIndexSupersessions;
-(int)getIndexSession;
-(int)getIndex;

@end
