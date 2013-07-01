//
//  InitViewController.m
//  iConfs
//
//  Created by Jareth on 6/3/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "InitViewController.h"
#import "AppDelegateProtocol.h"
#import "IConfs.h"

@interface InitViewController (){
    IConfs *theAppData;
}
@end

@implementation InitViewController

- (IConfs*) appData;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	IConfs* theAppDataObject;
	theAppDataObject = (IConfs*)[theDelegate appData];
	return theAppDataObject;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    theAppData = [self appData];
    [theAppData updateConferences];
    [theAppData bootableConfs];
    NSTimer* updateIt = [NSTimer scheduledTimerWithTimeInterval:300 target:self selector:@selector(timedUpdate:) userInfo:nil repeats:YES];
    
    
    
    self.TopViewController = [self.storyboard  instantiateViewControllerWithIdentifier:@"Home"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)timedUpdate:(NSTimer*) timy{
    
    NSLog(@"I'm at the timer");
    [self performSelectorInBackground:@selector(doUpdate) withObject:nil];
    
    
}

- (void)doUpdate{
    NSLog(@"I'm at the thread");
    [theAppData updateConferences];
    [theAppData updateNotifs];
}


@end
