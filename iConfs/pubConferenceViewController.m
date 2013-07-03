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

    IBOutlet UIImageView *pulpito;
    IBOutlet UILabel *allConfs;
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
    theAppData = [[IConfs alloc]init];
    ManageViewController *m=[ManageViewController alloc];
    
    theAppData= [m appData];
    [theAppData fetchConferences];
    otherConfs=[theAppData getRestOfConfs];
    
    
    
    
    if([otherConfs count] != 0){
     //   [pulpito setHidden:YES];
     //   [allConfs setHidden:YES];
        int aux = arc4random() % [otherConfs count];

        Conference *final=[otherConfs objectAtIndex:aux];
        for (Conference *c in otherConfs) {

            
            UIImage *im=[final getLogo];
            
            [picture setImage:im];
        }
        
           }
//else{
//    [pulpito setHidden:NO];
//    [allConfs setHidden:NO];
//
//}

[self.view setNeedsDisplay];

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
