//
//  ManageConfCell.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "ManageConfCell.h"

@implementation ManageConfCell

@synthesize checked;
@synthesize CheckButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)viewDidLoad
{
    checked = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)checkingButton:(id)sender {
    if (!checked) {
        [CheckButton setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        checked = YES;
    }else{
        [CheckButton setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        checked = NO;
    }
}
@end
