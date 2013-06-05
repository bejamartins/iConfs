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

@synthesize picture,session_theme,session_when,session_where,biography,IndexAux,navigationBar,bar,showPerson;

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
    biographies =[[NSArray alloc]initWithObjects:@"Speaker Bio", @"Author Bio",@"Person Bio",nil];
    imageArray = [[NSArray alloc]initWithObjects:@"speaker.jpg", @"author.jpg", @"conf.jpg",nil];
    speakers = [[NSArray alloc]initWithObjects:@"Speaker 1",@"Speaker 2",@"Speaker 3", nil];
    authors = [[NSArray alloc]initWithObjects:@"Author 1",@"Author 2",@"Author 3", nil];
    organization = [[NSArray alloc]initWithObjects:@"Person 1",@"Person 2",@"Person 3", nil];
    
    UIImage *a= [UIImage imageNamed: [imageArray objectAtIndex:showPerson] ];
    [picture setImage:a];
    NSString *navigationTitle;
    if(showPerson==0)
    navigationTitle=[speakers objectAtIndex:IndexAux];
    else if(showPerson==1){
        navigationTitle=[authors objectAtIndex:IndexAux];}
    else{
        navigationTitle=[organization objectAtIndex:IndexAux];
    }

    [bar setTitle:navigationTitle];
    [biography setText:[ biographies objectAtIndex:showPerson]];
   
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
