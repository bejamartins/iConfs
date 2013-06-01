//
//  ManageConfCell.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageConfCell : UICollectionViewCell

@property (nonatomic) BOOL checked;

@property (weak, nonatomic) IBOutlet UIButton *CheckButton;
@property (weak, nonatomic) IBOutlet UIImageView *IconConf;
@property (weak, nonatomic) IBOutlet UILabel *LabelConf;

- (IBAction)checkingButton:(id)sender;
@end
