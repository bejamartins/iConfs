//
//  TestingViewController.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 04/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "TestingViewController.h"

@interface TestingViewController ()

@end

@implementation TestingViewController

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
    IConfs* ic;
    ic = [[IConfs alloc] init];
    NSString* s = [ic getfetchedIDs];
	// Do any additional setup after loading the view.
    [self testLabel].text = s;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
