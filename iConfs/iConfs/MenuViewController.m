//
//  MenuViewController.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"
#import "AppDelegateProtocol.h"
#import "IConfs.h"
#import "OrganizerViewController.h"
#import "PersonViewController.h"
#import "AddRemoveSessionsViewController.h"
#import "MAEvent.h"

#import "MapViewController.h"

@interface MenuViewController ()
{
    NSArray *menuGen;
    NSArray *menuConf;
    NSArray *confs;
    BOOL showMenuConf;
    IConfs *theAppData;
}

@end

@implementation MenuViewController

@synthesize selectedConf;

#pragma - Data Fetch Method

- (IConfs*) appData
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
    
    [[self MenuView] setDelegate:self];
    [[self MenuView] setDataSource:self];
    
    theAppData = [self appData];
    
    menuGen = [[NSArray alloc] initWithObjects:@"Manage Conferences", @"Personal Agenda", nil];
    menuConf = [[NSArray alloc] initWithObjects:@"Sessions",@"People",@"Session Detail",@"Locations",@"Map View", nil];
    confs = [[NSArray alloc] initWithArray:[theAppData getMyConferences]];
    
    [[self slidingViewController] setAnchorRightPeekAmount:450.0f];
    [[self slidingViewController] setUnderLeftWidthLayout:ECFullWidth];
    
    showMenuConf = NO;
    
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"WP(42).jpg"]];
    self.view.backgroundColor = background;
    //[background release];
    
    
    /*[theAppData fetchConferences];
    [theAppData addConferenceWithID:@"c001"];
    Conference* c = ((Conference*)[theAppData getMyConferences][0]);
    NSLog(@"This is it: %@", [((SuperSession*)[[c getSuperSessions] allValues][0]) getTheme]);
    [theAppData subscribeSuperSessionInAgenda: ((SuperSession*)[[c getSuperSessions]allValues][0]) Conference:@"c001"];
    [theAppData getUnsubscribedSuperSessions];
    NSArray* s = [theAppData getUnsubscribedSuperSessionsByConferenceOrderedByDate:@"c001"];
    SuperSession* ss = ((SuperSession*)s[0]);
    //NSDictionary* eventsDic = [ss getAllEventsDicionary];
    NSArray* events = [ss getAllEventsOrderedByDate];
    Event* event = ((Event*)events[0]);
    //Event* eventD = ((Event*)[eventsDic allValues][0]);*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*)getMySuperSessions:(NSString*)iD
{
    return [theAppData getAgendaByConferenceOrderedByDate:iD];
}

- (NSArray*)getOtherSuperSessions:(NSString*)iD
{
    return [theAppData getUnsubscribedSuperSessionsByConferenceOrderedByDate:iD];
}

#pragma - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [menuGen count];
    else if (section == 1 && !showMenuConf)
        return 0;
    else if (section == 1)
        return [menuConf count];
    else
        return [confs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    if ([indexPath section] == 0)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [menuGen objectAtIndex:[indexPath row]]];
    else if ([indexPath section] == 1 && showMenuConf)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [menuConf objectAtIndex:[indexPath row]]];
    else if ([indexPath section] == 2)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [((Conference*)[confs objectAtIndex:[indexPath row]]) getName]];
    
    
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1 && showMenuConf) {
        return [selectedConf getName];
    }
    
    return @"";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [tableView bounds].size.width, 30)];
    
    UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, [tableView bounds].size.width - 10, 18)];
    
    [headerLabel setTextColor:[UIColor whiteColor]];
    
    [headerLabel setBackgroundColor:[UIColor clearColor]];
    
    [headerLabel setText:[[tableView dataSource] tableView:tableView titleForHeaderInSection:section]];
    
    [headerLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (NSArray*)sessionToMAEvents {
	NSString *iD = [[NSString alloc] initWithString:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID]];
    
    NSArray *myDict = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getAgendaByConferenceOrderedByDate:iD];
    
    NSArray *otherDict = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] appData] getUnsubscribedSuperSessionsByConferenceOrderedByDate:iD];
	
    NSMutableArray *tempEvents = [[NSMutableArray alloc] init];
    
    for (id ss in myDict) {
        MAEvent *event = [[MAEvent alloc] init];
        event.textColor = [UIColor whiteColor];
        event.allDay = NO;
        event.userInfo = NULL;
        [event setChecked:YES];
        event.backgroundColor = [UIColor brownColor];
        [event setTitle:[ss getTheme]];
        [event setStart:[ss getStartDate]];
        [event setSsID:[(SuperSession*)ss getID]];
        
        NSMutableArray *eventsInSS;
        
        /*for (id e in [ss getUserAllEventsOrderedByDate]) {
         MAEvent *tEvent = [[MAEvent alloc] init];
         event.textColor = [UIColor whiteColor];
         event.allDay = NO;
         event.userInfo = NULL;
         [event setChecked:YES];
         event.backgroundColor = [UIColor purpleColor];
         [event setTitle:[e getTheme]];
         [event setStart:[e getStartDate]];
         [event setSsID:[(SuperSession*)ss getID]];
         [event setSID:[(Event*)e getID]];
         
         [eventsInSS addObject:tEvent];
         }*/
        
        /*for (id e in [ss getUnsubscribedEvents]) {
         MAEvent *tEvent = [[MAEvent alloc] init];
         event.textColor = [UIColor whiteColor];
         event.allDay = NO;
         event.userInfo = NULL;
         [event setChecked:NO];
         event.backgroundColor = [UIColor purpleColor];
         [event setTitle:[e getTheme]];
         [event setStart:[e getStartDate]];
         [event setSsID:[(SuperSession*)ss getID]];
         [event setSID:[(Event*)e getID]];
         
         [eventsInSS addObject:tEvent];
         }*/
        
        [event setEventsOfSS:eventsInSS];
        
        [tempEvents addObject:event];
    }
    
    for (SuperSession* ss in otherDict) {
        MAEvent *event = [[MAEvent alloc] init];
        event.textColor = [UIColor whiteColor];
        event.allDay = NO;
        event.userInfo = NULL;
        [event setChecked:NO];
        event.backgroundColor = [UIColor purpleColor];
        [event setTitle:[ss getTheme]];
        [event setStart:[ss getStartDate]];
        [event setSsID:[(SuperSession*)ss getID]];
        
        NSMutableArray *eventsInSS;
        /*for (id e in [ss getUnsubscribedEvents]) {
         MAEvent *tEvent = [[MAEvent alloc] init];
         event.textColor = [UIColor whiteColor];
         event.allDay = NO;
         event.userInfo = NULL;
         [event setChecked:NO];
         event.backgroundColor = [UIColor purpleColor];
         [event setTitle:[e getTheme]];
         [event setStart:[e getStartDate]];
         [event setSsID:[(SuperSession*)ss getID]];
         [event setSID:[(Event*)e getID]];
         
         [eventsInSS addObject:tEvent];
         }*/
        
        [event setEventsOfSS:eventsInSS];
        
        [tempEvents addObject:event];
    }
    
    return tempEvents;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([indexPath section] == 0){
        showMenuConf = NO;
        NSString *iD = [NSString stringWithFormat:@"%@", [self.MenuView cellForRowAtIndexPath:indexPath].textLabel.text];
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        
        [[self MenuView] reloadData];
        
        [[self slidingViewController] anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
            [[self slidingViewController] setTopViewController:newTopViewController];
            [[[[self slidingViewController] topViewController] view] setFrame:frame];
            [[self slidingViewController] resetTopView];
        }];
    }else if ([indexPath section] == 1){
        NSString *iD = [NSString stringWithFormat:@"%@", [self.MenuView cellForRowAtIndexPath:indexPath].textLabel.text];
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        
        [[self MenuView] deselectRowAtIndexPath:indexPath animated:NO];
        
        [[self slidingViewController] anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
            [[self slidingViewController] setTopViewController:newTopViewController];
            [[[[self slidingViewController] topViewController] view] setFrame:frame];
            
            [[self slidingViewController] resetTopView];
        }];
    }else{
        selectedConf = (Conference*)[confs objectAtIndex:[indexPath row]];
        showMenuConf = YES;
        [[self MenuView] reloadData];
        
        NSString *iD = @"Conference";
        
        UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
        
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
    }
}

- (IBAction)homeButtonPressed:(id)sender
{
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Home"];
    
    [[self slidingViewController] anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        [[self slidingViewController] resetTopView];
    }];
}

- (void)setSelectedConf:(Conference *)sConf
{
    selectedConf = sConf;
    showMenuConf = YES;
    [[self MenuView] reloadData];
}

- (void)deselectConf
{
    showMenuConf = NO;
    [[self MenuView] reloadData];
}

@end


