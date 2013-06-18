//
//  BluePrintsViewController.h
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlueprintContainerViewController.h"
#import "Conference.h"

@interface BluePrintsViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property NSMutableDictionary *blueprints;
@property (strong, nonatomic) UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UIView *placesContainer;
@property (strong, nonatomic) IBOutlet UIView *bpContainer;
-(UIImage*) returnImagePath:(NSString*)imagePath;
@property Conference *c;
@end
