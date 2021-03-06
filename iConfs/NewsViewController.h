//
//  NewsViewController.h
//  iConfs
//
//  Created by Ana T on 19/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong, nonatomic) UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) UIButton *HomeButton;
@property (strong, nonatomic) UIButton *BackButton;
@property UIViewController *previous;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)segmentedChanged:(id)sender;
-(void)changeNews:(NSArray*)nws;
- (void)changePrevious:(UIViewController*)vc;
@end
