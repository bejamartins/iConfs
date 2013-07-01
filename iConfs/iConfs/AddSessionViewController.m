//
//  AddSessionViewController.m
//  iConfs
//
//  Created by Jareth on 6/20/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "AddSessionViewController.h"
#import "MAWeekView.h"
#import "MAEvent.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface AddSessionViewController (){
    NSArray *events;
}

@property (strong, nonatomic) IBOutlet UIButton *MenuButton;

@end

@implementation AddSessionViewController

@synthesize MenuButton, conf, AgendaView;

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
	
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
    }
    
    [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
    [self setMenuButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [MenuButton setFrame:CGRectMake(8, 10, 34, 24)];
    [MenuButton setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [MenuButton addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:MenuButton];
    
    events = [self getEventsFromConf];
    
    [AgendaView setWeek:[[events objectAtIndex:0] getDate]];
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"GB.jpg"]];
    self.view.backgroundColor = background;
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

- (NSArray*)getEventsFromConf{
    NSMutableArray *e = [[NSMutableArray alloc] init];
    
    [e addObjectsFromArray:[conf getAllEvents]];
    
    return e;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

/* Implementation for the MAWeekViewDataSource protocol */

- (NSArray *)weekView:(MAWeekView *)weekView eventsForDate:(NSDate *)startDate {
    
	NSMutableArray *arr;
	
	for (Event *e in events) {
        if ([e getDate] == startDate) {
            [arr addObject:[self event:e]];
        }
    }
	
	return arr;
}

- (MAEvent *)event:(Event *)e {
	static int counter;
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[dict setObject:[NSString stringWithFormat:@"number %i", counter++] forKey:@"test"];
	
	MAEvent *event = [[MAEvent alloc] init];
	event.backgroundColor = [UIColor purpleColor];
	event.textColor = [UIColor whiteColor];
	event.allDay = NO;
	event.userInfo = dict;
    [event setChecked:NO];
    [event setTitle:[e getTitle]];
    [event setStart:[e getDate]];
    [event setEnd:[[NSDate alloc] initWithTimeInterval:(30*60) sinceDate:[e getDate]]];
	return event;
}

@end
