//
//  AgendaPreview.m
//  iConfs
//
//  Created by Ana T on 19/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "AgendaPreview.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
@interface AgendaPreview ()

@end

@implementation AgendaPreview

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
- (IBAction)openAgenda:(id)sender {
    
    
    NSString *iD = @"Personal Agenda";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
}

@end
