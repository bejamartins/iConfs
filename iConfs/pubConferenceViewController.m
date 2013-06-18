//
//  pubConferenceViewController.m
//  iConfs
//
//  Created by Ana T on 18/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "pubConferenceViewController.h"
#import "ManageViewController.h"
#import "IConfs.h"
#import "Conference.h"
@interface pubConferenceViewController (){
    NSArray *otherConfs;
    IConfs *theAppData;

}

@end

@implementation pubConferenceViewController
@synthesize picture;

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
    ManageViewController *m=[ManageViewController alloc];
    theAppData= [m appData];
    [theAppData fetchConferences];

    otherConfs = [theAppData getRestOfConfs];
    //NSLog(<#NSString *format, ...#>)
    Conference *final=[otherConfs objectAtIndex:0];
    //Event *e= [[final getAllEvents] objectAtIndex:0];
    // int counter=0;
    for (Conference *c in otherConfs) {
        //        NSArray *ev=[c getAllEvents];
        //      Event *eAux=[ev objectAtIndex:<#(NSUInteger)#>];
        //  if([[eAux getDate] )
        
        UIImage *im=[final getLogo];
        
        [picture setImage:im];
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
