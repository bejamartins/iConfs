//
//  newConferenceContainer.h
//  iConfs
//
//  Created by Ana T on 05/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface newConferenceContainer : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    
    // IBOutlet UICollectionView *collection;
    
}

//@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property (strong, nonatomic) IBOutlet UICollectionView *collection;
@property  NSArray *myConfs;

@end

