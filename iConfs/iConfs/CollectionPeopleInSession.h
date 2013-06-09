//
//  CollectionPeopleInSession.h
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionPeopleInSession : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    //array with the people envolved in the session
    NSArray *peopleInSession;
    //arrays com autores , speakers caso seja preciso.
    NSArray *authorsInSession;
    NSArray *speakersInSession;
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *collection;
    
@end
