//
//  AppDelegate.h
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegateProtocol.h"

@class IConfs;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    IConfs* appData;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) IConfs* appData;

@end
