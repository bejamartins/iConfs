//
//  PersonViewController.m
//  iConfs
//
//  Created by Ana T on 04/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PersonViewController.h"

@interface PersonViewController ()
@property (strong, nonatomic) IBOutlet UINavigationItem *bar;

@end

@implementation PersonViewController

@synthesize picture,session_theme,session_when,session_where,biography,IndexAux,navigationBar,bar;

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
    biographies =[[NSArray alloc]initWithObjects:@"First Bio", @"Second Bio",@"Third Bio",nil];
    imageArray = [[NSArray alloc]initWithObjects:@"conf.jpg", @"conf.jpg", @"conf.jpg",nil];
    nameArray = [[NSArray alloc]initWithObjects:@"Person 1",@"Person 2",@"Person 3", nil];
    companyArray = [[NSArray alloc]initWithObjects:@"FCT",@"UNL",@"DI - FCT", nil];
    
    UIImage *a= [UIImage imageNamed: [imageArray objectAtIndex:IndexAux] ];
    [picture setImage:a];
    NSString *navigationTitle=[nameArray objectAtIndex:IndexAux];
    [bar setTitle:navigationTitle];
    [biography setText:[ biographies objectAtIndex:IndexAux]];
   
    //[picture setImage:passPicture];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
