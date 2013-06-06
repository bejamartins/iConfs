//
//  ConferenceScreenViewController.m
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "ConferenceScreenViewController.h"

@interface ConferenceScreenViewController ()
//@property (strong, nonatomic) IBOutlet UINavigationItem *bar;
@property (strong, nonatomic) IBOutlet UINavigationItem *bar;

@end

@implementation ConferenceScreenViewController
@synthesize conferenceName;

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
    NSLog(@"Name em ConferenceScreen= %@", conferenceName);
    
    [[ self bar] setTitle:conferenceName];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)changeName:(NSString *)name{
    conferenceName=name;
    NSLog(@"Mudei o nome em Screen, name= %@", conferenceName);
    [[ self bar] setTitle:conferenceName];
    
    
}

@end
