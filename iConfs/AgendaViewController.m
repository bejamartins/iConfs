//
//  AgendaViewController.m
//  iConfs
//
//  Created by Jareth on 6/10/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "AgendaViewController.h"
#import "MAWeekView.h"
#import "MAEvent.h"
#import "MAEventKitDataSource.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@interface AgendaViewController ()
{
    BOOL isRemoving;
    BOOL choosingConf;
    NSArray *myConfs;
}
@property (readonly) MAEvent *event;
@property (readonly) MAEventKitDataSource *eventKitDataSource;
@property (weak, nonatomic) IBOutlet UIButton *AddSessionButton;
@property (weak, nonatomic) IBOutlet UIButton *RemoveSessionsButton;
@property (weak, nonatomic) IBOutlet UITableView *ConfsTable;
@end

@implementation AgendaViewController

@synthesize MenuButton, AddSessionButton, RemoveSessionsButton, ConfsTable;

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
    
    isRemoving = NO;
    choosingConf = NO;
    
    myConfs = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getMyConferences];
}

- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

/* Implementation for the MAWeekViewDataSource protocol */


/*- (NSArray *)weekView:(MAWeekView *)weekView eventsForDate:(NSDate *)startDate {
    return [self.eventKitDataSource weekView:weekView eventsForDate:startDate];
}*/

static int counter = 7 * 5;

- (NSArray *)weekView:(MAWeekView *)weekView eventsForDate:(NSDate *)startDate {
	counter--;
	
	unsigned int r = arc4random() % 24;
	unsigned int r2 = arc4random() % 10;
	
	NSArray *arr;
	
	if (counter < 0) {
		arr = [NSArray arrayWithObjects: self.event, nil];
	} else {
		arr = (r <= 5 ? [NSArray arrayWithObjects: self.event, self.event, nil] : [NSArray arrayWithObjects: self.event, self.event, self.event, nil]);
		
		((MAEvent *) [arr objectAtIndex:1]).title = @"All-day events test";
		((MAEvent *) [arr objectAtIndex:1]).allDay = YES;
		
		if (r > 5) {
			((MAEvent *) [arr objectAtIndex:2]).title = @"Foo!";
            
            ((MAEvent *) [arr objectAtIndex:2]).backgroundColor = [UIColor brownColor];
            
			((MAEvent *) [arr objectAtIndex:2]).allDay = YES;
		}
	}
	
	((MAEvent *) [arr objectAtIndex:0]).title = @"Event lorem ipsum es dolor test";
	
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:startDate];
	[components setHour:r];
	[components setMinute:0];
	[components setSecond:0];
	
	((MAEvent *) [arr objectAtIndex:0]).start = [CURRENT_CALENDAR dateFromComponents:components];
	
	[components setHour:r+1];
	[components setMinute:0];
	
	((MAEvent *) [arr objectAtIndex:0]).end = [CURRENT_CALENDAR dateFromComponents:components];
	
	if (r2 > 5) {
        ((MAEvent *) [arr objectAtIndex:0]).backgroundColor = [UIColor brownColor];
	}
	
	return arr;
}

- (MAEvent *)event {
	static int counter;
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[dict setObject:[NSString stringWithFormat:@"number %i", counter++] forKey:@"test"];
	
	MAEvent *event = [[MAEvent alloc] init];
	event.backgroundColor = [UIColor purpleColor];
	event.textColor = [UIColor whiteColor];
	event.allDay = NO;
	event.userInfo = dict;
    [event setChecked:NO];
	return event;
}

- (MAEventKitDataSource *)eventKitDataSource {
    if (!_eventKitDataSource) {
        _eventKitDataSource = [[MAEventKitDataSource alloc] init];
    }
    return _eventKitDataSource;
}

/* Implementation for the MAWeekViewDelegate protocol */

- (void)weekView:(MAWeekView *)weekView eventTapped:(MAEvent *)event {
    if (isRemoving) {
        [event setChecked:YES];
        [(MAWeekView*)[self AgendaView] reloadData];
    }else {
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
        NSString *eventInfo = [NSString stringWithFormat:@"Event tapped: %02i:%02i. Userinfo: %@", [components hour], [components minute], [event.userInfo objectForKey:@"test"]];
	
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                    message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)weekView:(MAWeekView *)weekView eventDragged:(MAEvent *)event {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
	NSString *eventInfo = [NSString stringWithFormat:@"Event dragged to %02i:%02i. Userinfo: %@", [components hour], [components minute], [event.userInfo objectForKey:@"test"]];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                    message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}

- (IBAction)addSessions:(id)sender {
    if (choosingConf) {
        [ConfsTable setHidden:YES];
        choosingConf = NO;
    }else{
        [ConfsTable setHidden:NO];
        choosingConf = YES;
    }
}

- (IBAction)RemoveSessions:(id)sender {
    if (!isRemoving) {
        isRemoving = YES;
        [(MAWeekView*)[self AgendaView] isRemoving];
        [(MAWeekView*)[self AgendaView] reloadData];
    }else {
        isRemoving = NO;
        [(MAWeekView*)[self AgendaView] doneRemoving];
        for (NSDate *weekday in [(MAWeekView*)[self AgendaView] getWeekDays]) {
            NSArray *events = [self weekView:(MAWeekView*)[self AgendaView] eventsForDate:weekday];
            
            for (id e in events) {
                
            }
        }
        [(MAWeekView*)[self AgendaView] reloadData];
    }
}

#pragma - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [myConfs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];	
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [(Conference*)[myConfs objectAtIndex:[indexPath row]] getName]];
    
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [(MenuViewController*)[[self slidingViewController] underLeftViewController] setSelectedConf:(Conference*)[myConfs objectAtIndex:[indexPath row]]];
    
    UIViewController *newTopViewController;
    
    newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"AddSession"];
    
    [[self slidingViewController] setTopViewController:newTopViewController];
}

@end
