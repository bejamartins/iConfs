//
//  SessionsViewController.m
//  iConfs
//
//  Created by Jareth on 6/22/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "AddRemoveSessionsViewController.h"
#import "MAWeekView.h"
#import "MAEvent.h"
#import "MAEventKitDataSource.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

#import "AppDelegateProtocol.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@interface AddRemoveSessionsViewController (){
    BOOL isEditing;
    NSArray *Events;
}

@property (weak, nonatomic) IBOutlet MAWeekView *AgendaView;
@property (readonly) MAEventKitDataSource *eventKitDataSource;
@property (weak, nonatomic) IBOutlet UIButton *EditButton;
@property (strong, nonatomic) IBOutlet UIButton *MenuButton;
@property (strong, nonatomic) IBOutlet UIButton *HomeButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ViewOptions;

@end

@implementation AddRemoveSessionsViewController

@synthesize AgendaView, EditButton, MenuButton, HomeButton, ViewOptions;

- (IConfs*) appData;
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	IConfs* theAppDataObject;
	theAppDataObject = (IConfs*)[theDelegate appData];
	return theAppDataObject;
}

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
    
    isEditing = NO;
    
    [self sessionToMAEvents];
    
    [[self AgendaView] setStartDate:[(MAEvent*)[Events objectAtIndex:0] start]];
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
    
    NSMutableArray *arr;
    
    for (MAEvent *ss in Events) {
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:[ss start]];
        NSDateComponents *componentsStart = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:startDate];
        
        if ([components day] == [componentsStart day]) {
            if ([ViewOptions selectedSegmentIndex] == 0) {
                [arr addObject:ss];
            } else {
                for (id e in [ss eventsOfSS]) {
                    [arr addObject:e];
                }
            }
        }
    }
    
	return arr;
}

- (void)sessionToMAEvents {
	NSString *iD = [[NSString alloc] initWithString:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID]];
    
    NSLog([[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getName]);
    
    IConfs *data = [self appData];
    
    NSArray *myDict = [[NSArray alloc] initWithArray:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getAgendaByConferenceOrderedByDate:iD]];
    
    NSArray *otherDict = [[NSArray alloc] initWithArray:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getUnsubscribedSuperSessionsByConferenceOrderedByDate:iD]];
    
    myDict = [data getAgendaByConferenceOrderedByDate:iD];
    otherDict = [data getUnsubscribedSuperSessionsByConferenceOrderedByDate:iD];
    
    NSLog([NSString stringWithFormat:@"myEvents count : %d", [myDict count]]);
    NSLog([NSString stringWithFormat:@"otherEvents count : %d", [otherDict count]]);
	
    NSMutableArray *tempEvents = [[NSMutableArray alloc] init];
    
    if ([ViewOptions selectedSegmentIndex] == 0) {
        for (id ss in myDict) {
            MAEvent *event = [[MAEvent alloc] init];
            event.textColor = [UIColor whiteColor];
            event.allDay = NO;
            event.userInfo = NULL;
            [event setChecked:YES];
            event.backgroundColor = [UIColor brownColor];
            [event setTitle:[ss getTheme]];
            [event setStart:[ss getStartDate]];
            [event setEnd:[[NSDate alloc] initWithTimeInterval:(30*60) sinceDate:[ss getStartDate]]];
            [event setSsID:[(SuperSession*)ss getID]];
            
            NSMutableArray *eventsInSS;
            for (id e in [ss getUserAllEventsOrderedByDate]) {
                MAEvent *tEvent = [[MAEvent alloc] init];
                event.textColor = [UIColor whiteColor];
                event.allDay = NO;
                event.userInfo = NULL;
                [event setChecked:YES];
                event.backgroundColor = [UIColor purpleColor];
                [event setTitle:[e getTheme]];
                [event setStart:[e getStartDate]];
                [event setEnd:[[NSDate alloc] initWithTimeInterval:(30*60) sinceDate:[e getStartDate]]];
                [event setSsID:[(SuperSession*)ss getID]];
                [event setSID:[(Event*)e getID]];
                
                [eventsInSS addObject:tEvent];
            }
            
            for (id e in [ss getUnsubscribedEvents]) {
                MAEvent *tEvent = [[MAEvent alloc] init];
                event.textColor = [UIColor whiteColor];
                event.allDay = NO;
                event.userInfo = NULL;
                [event setChecked:NO];
                event.backgroundColor = [UIColor purpleColor];
                [event setTitle:[e getTheme]];
                [event setStart:[e getStartDate]];
                [event setEnd:[[NSDate alloc] initWithTimeInterval:(30*60) sinceDate:[e getStartDate]]];
                [event setSsID:[(SuperSession*)ss getID]];
                [event setSID:[(Event*)e getID]];
                
                [eventsInSS addObject:tEvent];
            }
            
            [event setEventsOfSS:eventsInSS];
            
            [tempEvents addObject:event];
        }
        
        for (id ss in otherDict) {
            MAEvent *event = [[MAEvent alloc] init];
            event.textColor = [UIColor whiteColor];
            event.allDay = NO;
            event.userInfo = NULL;
            [event setChecked:NO];
            event.backgroundColor = [UIColor purpleColor];
            [event setTitle:[ss getTheme]];
            [event setStart:[ss getStartDate]];
            [event setEnd:[[NSDate alloc] initWithTimeInterval:(30*60) sinceDate:[ss getStartDate]]];
            [event setSsID:[(SuperSession*)ss getID]];
            
            NSMutableArray *eventsInSS;
            for (id e in [ss getUnsubscribedEvents]) {
                MAEvent *tEvent = [[MAEvent alloc] init];
                event.textColor = [UIColor whiteColor];
                event.allDay = NO;
                event.userInfo = NULL;
                [event setChecked:NO];
                event.backgroundColor = [UIColor purpleColor];
                [event setTitle:[e getTheme]];
                [event setStart:[e getStartDate]];
                [event setEnd:[[NSDate alloc] initWithTimeInterval:(30*60) sinceDate:[e getStartDate]]];
                [event setSsID:[(SuperSession*)ss getID]];
                [event setSID:[(Event*)e getID]];
                
                [eventsInSS addObject:tEvent];
            }
            
            [event setEventsOfSS:eventsInSS];
            
            [tempEvents addObject:event];
        }

        Events = [[NSArray alloc] initWithArray:tempEvents];
    }
}

/* Implementation for the MAWeekViewDelegate protocol */

- (void)weekView:(MAWeekView *)weekView eventTapped:(MAEvent *)event {
    
    if (isEditing) {
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
        NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
        NSString *eventInfo = [NSString stringWithFormat:@"Event tapped: %02i:%02i. Userinfo: %@", [components hour], [components minute], [event.userInfo objectForKey:@"test"]];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                        message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)editEvents:(id)sender {
    if (isEditing) {
        isEditing = NO;
        [AgendaView doneEditing];
        [[self EditButton] setTitle:@"Add/Remove Sessions" forState:UIControlStateNormal];
        [AgendaView reloadData];
    } else {
        isEditing = YES;
        [AgendaView isEditing];
        [[self EditButton] setTitle:@"Finished" forState:UIControlStateNormal];
        [AgendaView reloadData];
    }
}

- (IBAction)changedOption:(id)sender {
    [AgendaView reloadData];
}

@end
