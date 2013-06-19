//
//  ConferenceScreenViewController.m
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "ConferenceScreenViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "Conference.h"

@interface ConferenceScreenViewController (){
    Conference *conf;

}
//@property (strong, nonatomic) IBOutlet UINavigationItem *bar;

@end

@implementation ConferenceScreenViewController
@synthesize conferenceName;
@synthesize MenuButton,notification_number,notification_title,Notification_text;

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
     conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];
    //NSLog(@"Name em ConferenceScreen= %@", conferenceName);
      conferenceName=  [conf getName];
    [[ self bar] setTitle:conferenceName];
    [super viewDidLoad];
    
    NSUInteger index= [[conf getNotifications]count];
    index--;
    Notification *lastNotification=[[conf getNotifications]objectAtIndex:index ];
	// Do any additional setup after loading the view.
    
    [notification_title setText:[lastNotification getTitle]];
     [Notification_text setText:[lastNotification getText]];
    NSString *totalNotifications = [NSString stringWithFormat:@"%i", index+1];
    NSString *currentNotification = [NSString stringWithFormat:@"%i",index+1 ];
    NSString *notificationNumb=[NSString stringWithFormat:@"%@/%@",currentNotification,totalNotifications];
    [notification_number setText:notificationNumb];


    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
    [self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
    [MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:MenuButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}

-(void)changeName:(NSString *)name{
    conferenceName=name;
    NSLog(@"Mudei o nome em Screen, name= %@", conferenceName);
    [[ self bar] setTitle:conferenceName];
    
    
}

@end
