//
//  SessionViewController.m
//  iConfs
//
//  Created by Ana T on 09/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "SessionViewController.h"

@interface SessionViewController ()

@end

@implementation SessionViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showInPlant:(id)sender {
}

- (IBAction)addToAgenda:(id)sender {
}

- (void) setSessionName:(NSString *)sessionName{
    [self.sessionName setText:sessionName] ;
}
- (void) setSessionWhen:(NSString *)sessionWhen{
    [self.sessionWhen setText:sessionWhen];
}
- (void) setSessionWhere:(NSString *)sessionWhere{
    [self.sessionWhere setText:sessionWhere];
}

@end
