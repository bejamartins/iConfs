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
#import "Notification.h"

@interface ConferenceScreenViewController (){
    Conference *conf;
    NSUInteger currentNotIndex;
    Notification *currentNotification;
    NSInteger numberOfNots;
    NSArray *notifications;

}
//@property (strong, nonatomic) IBOutlet UINavigationItem *bar;
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

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
    //NSLog(@"Name em ConferenceScreen= %@", conferenceName);
  
    
    
    [super viewDidLoad];
    
    
    
    if(conf==nil){
        conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];

        notifications=[conf getNotifications];
        numberOfNots=[notifications count];
        currentNotIndex=numberOfNots-1;
        currentNotification=[notifications objectAtIndex:currentNotIndex];
        [self.forwardButton setEnabled:NO];
        
        conferenceName=  [conf getName];
        [[ self bar] setTitle:conferenceName];

    }
    
    
    
    

	// Do any additional setup after loading the view.
    
    [notification_title setText:[currentNotification getTitle]];
     [Notification_text setText:[currentNotification getText]];
    NSString *totalNotifications = [NSString stringWithFormat:@"%i", numberOfNots];
    NSString *numberCurrentNotification = [NSString stringWithFormat:@"%i",currentNotIndex+1 ];
    NSString *notificationNumb=[NSString stringWithFormat:@"%@/%@",numberCurrentNotification,totalNotifications];
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

- (IBAction)forwardButton:(id)sender {
    
        currentNotIndex++;
    if(currentNotIndex==(NSInteger)1){
        [self.backbutton setEnabled:YES];

    }
        currentNotification=[notifications objectAtIndex:currentNotIndex];

        [self viewDidLoad];
    if(currentNotIndex==(NSInteger)numberOfNots-1){
        [self.forwardButton setEnabled:NO];
}
}
- (IBAction)backButton:(id)sender {
    currentNotIndex--;
    currentNotification=[notifications objectAtIndex:currentNotIndex];
    [self.forwardButton setEnabled:YES];
    [self viewDidLoad];
    
    if(currentNotIndex==0){
        [self.backbutton setEnabled:NO];

    
}
}

@end
