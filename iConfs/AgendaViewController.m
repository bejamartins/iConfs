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
#import "SessionsViewController.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@interface AgendaViewController ()
{
    BOOL isRemoving;
    NSArray *Events;
    MAEvent *tappedEvent;
}
@property (readonly) MAEvent *event;
@property (readonly) MAEventKitDataSource *eventKitDataSource;
@property (weak, nonatomic) IBOutlet UIButton *RemoveSessionsButton;
@property (weak, nonatomic) IBOutlet MAWeekView *AgendaView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ViewOptions;
@end

@implementation AgendaViewController

@synthesize MenuButton, RemoveSessionsButton,HomeButton, AgendaView, ViewOptions;

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
    
    [self setHomeButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [HomeButton setFrame:CGRectMake(45, 0, 43, 40)];
    [HomeButton setBackgroundImage:[UIImage imageNamed:@"white_home.png"] forState:UIControlStateNormal];
    [HomeButton addTarget:self action:@selector(goHome:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:HomeButton];
    
    [self sessionToMAEvents];
    
    [AgendaView setupCustomInitialisation];
    
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

- (IBAction)goHome:(id)sender{
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

/* Implementation for the MAWeekViewDataSource protocol */

- (NSArray *)weekView:(MAWeekView *)weekView eventsForDate:(NSDate *)startDate {
    
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableArray *arrSS = [[NSMutableArray alloc] init];
    
    for (MAEvent* ss in Events) {
        
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[(MAEvent*)ss start]];
        NSDateComponents *componentsStart = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:startDate];
        
        if ([components day] == [componentsStart day]) {
            if ([ss checked]) {
                [ss setBackgroundColor:[UIColor greenColor]];
                [arrSS addObject:ss];
            } else {
                [ss setBackgroundColor:[UIColor brownColor]];
                [arrSS addObject:ss];
            }
            
            for (id e in [ss eventsOfSS]) {
                if ([e checked]) {
                    [e setBackgroundColor:[UIColor blueColor]];
                    [arr addObject:e];
                } else {
                    [e setBackgroundColor:[UIColor orangeColor]];
                    [arr addObject:e];
                }
            }
        }
    }
    
    
    
    
    if ([ViewOptions selectedSegmentIndex] == 0) {
        [self sameTimeSS:arrSS];
        return arrSS;
    } else {
        [self sameTimeSS:arr];
        return arr;
    }
}

- (void)sameTimeSS:(NSArray*)events {
    for (int i = 0; i < [events count]; i++) {
        
        MAEvent *event = [events objectAtIndex:i];
        
        if (i == ([events count] - 1)) {
            
            [event setSameTimeEvents:1];
            [event setWhichSame:0];
            
        } else {
            int count = 1;
            MAEvent *e;
            NSMutableArray *sameTimeEvents = [[NSMutableArray alloc] init];
            [sameTimeEvents addObject:event];
            
            for (; (count + i) < [events count]; count++) {
                e = [events objectAtIndex:count + i];
                
                NSDate *eventStart = [e start];
                
                if (!([eventStart compare:[event start]] == NSOrderedSame || [eventStart compare:[event end]] == NSOrderedAscending)) {
                    break;
                }
                
                [sameTimeEvents addObject:e];
            }
            
            [event setSameTimeEvents:[sameTimeEvents count]];
            [event setWhichSame:0];
            
            for (int y = 1; y < count; y++) {
                
                e = [events objectAtIndex:y + i];
                
                [e setSameTimeEvents:[sameTimeEvents count]];
                [e setWhichSame:y];
            }
            
            i += (count - 1);
        }
    }
}

- (void)sessionToMAEvents {
	NSString *iD = [[NSString alloc] initWithString:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID]];
    
    NSArray *myDict = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getAgendaByConferenceOrderedByDate:iD];
	
    NSMutableArray *tempEvents = [[NSMutableArray alloc] init];
    
    for (CustomizableSuperSession* ss in myDict) {
        MAEvent *event = [[MAEvent alloc] init];
        event.textColor = [UIColor whiteColor];
        event.allDay = NO;
        event.userInfo = NULL;
        [event setChecked:YES];
        [event setTitle:[ss getTheme]];
        [event setStart:[ss getStartDate]];
        [event setEnd:[ss calculateEndDate]];
        [event setSsID:[(SuperSession*)ss getID]];
        
        NSMutableArray *eventsInSS = [[NSMutableArray alloc] init];
        
        for (Session* e in [ss getUserAllEventsOrderedByDate]) {
            MAEvent *tEvent = [[MAEvent alloc] init];
            tEvent.textColor = [UIColor whiteColor];
            tEvent.allDay = NO;
            tEvent.userInfo = NULL;
            [tEvent setChecked:YES];
            [tEvent setTitle:[e getTheme]];
            [tEvent setStart:[e getDate]];
            [tEvent setEnd:[e getEventEnd]];
            [tEvent setSsID:[(SuperSession*)ss getID]];
            [tEvent setSID:[(Event*)e getID]];
            
            [eventsInSS addObject:tEvent];
        }
        
        [event setEventsOfSS:eventsInSS];
        
        [tempEvents addObject:event];
    }
    
    Events = tempEvents;
}

/* Implementation for the MAWeekViewDelegate protocol */

- (void)weekView:(MAWeekView *)weekView eventTapped:(MAEvent *)event {
    
    if (isRemoving) {
        if ([ViewOptions selectedSegmentIndex] == 0) {
            if ([event checked]) {
                for (MAEvent *ss in Events) {
                    if ([ss ssID] == [event ssID]){
                        [ss setChecked:NO];
                        for (MAEvent *e in [ss eventsOfSS]) {
                            [e setChecked:NO];
                        }
                        
                        break;
                    }
                }
            } else {
                for (MAEvent *ss in Events) {
                    if ([ss ssID] == [event ssID]){
                        [ss setChecked:YES];
                        for (MAEvent *e in [ss eventsOfSS]) {
                            [e setChecked:YES];
                        }
                        
                        break;
                    }
                }
            }
        } else {
            if ([event checked]) {
                for (MAEvent *ss in Events) {
                    if ([ss ssID] == [event ssID]){
                        [ss setChecked:NO];
                        for (MAEvent *e in [ss eventsOfSS]) {
                            if ([e sID] == [event sID]) {
                                [e setChecked:NO];
                            } else if ([e checked]) {
                                [ss setChecked:YES];
                            }
                        }
                        
                        break;
                    }
                }
            } else {
                for (MAEvent *ss in Events) {
                    if ([ss ssID] == [event ssID]){
                        [ss setChecked:YES];
                        for (MAEvent *e in [ss eventsOfSS]) {
                            if ([e sID] == [event sID]) {
                                [e setChecked:YES];
                            }
                        }
                        
                        break;
                    }
                }
            }
        }
        
        [AgendaView reloadData];
    } else {
        tappedEvent = [[MAEvent alloc] init];
        
        tappedEvent = event;
        
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
        NSString *eventInfo = [NSString stringWithFormat:@"Event tapped: %02i:%02i. Userinfo: %@", [components hour], [components minute], [event.userInfo objectForKey:@"test"]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                        message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"More Info", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != [alertView cancelButtonIndex]) {
        NSString *iD = @"Session Detail";
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        
        [(SessionsViewController*)newTopViewController setPrevious:[[self slidingViewController] topViewController]];
        
        [(SessionsViewController*)newTopViewController auxChangeSuperSession:[tappedEvent ssID]];
        
        [(SessionsViewController*)newTopViewController changeSession:[tappedEvent sID]];
        
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        
        [[self slidingViewController] resetTopView];
    }
}

- (IBAction)removeEvents:(id)sender {
    if (isRemoving) {
        isRemoving = NO;
        [self saveChanges];
        [[self RemoveSessionsButton] setTitle:@"Remove Sessions" forState:UIControlStateNormal];
        [AgendaView reloadData];
    } else {
        isRemoving = YES;
        [[self RemoveSessionsButton] setTitle:@"Finished" forState:UIControlStateNormal];
        [AgendaView reloadData];
    }
}

- (void)saveChanges {
    
    NSString *iD = [[NSString alloc] initWithString:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID]];
    
    NSMutableArray *newEvents = [[NSMutableArray alloc] init];
    
    for (MAEvent* e in Events) {
        if ([e checked]) {
            [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] subscribeSuperSessionInAgendaByID:[e ssID] Conference:iD];
            [newEvents addObject:e];
            
            for (CustomizableSuperSession* cSS in [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getAgendaByConferenceOrderedByDate:iD]) {
                if ([cSS getID] == [e ssID]) {
                    for (MAEvent* event in [e eventsOfSS]) {
                        if (![event checked]) {
                            [cSS unsubscribeAnyEvent:[event sID]];
                        }
                    }
                    
                    break;
                }
            }
        } else {
            [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] unsubscribeSuperSessionInAgenda:[e ssID]];
        }
    }
    
    Events = newEvents;
}

- (IBAction)chengedOption:(id)sender {
    [AgendaView reloadData];
}

@end
