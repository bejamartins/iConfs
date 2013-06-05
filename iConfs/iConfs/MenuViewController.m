//
//  MenuViewController.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"
#import "IConfs.h"

@interface MenuViewController ()
{
    Conference *selectedConf;
    NSArray *menuGen;
    NSArray *menuConf;
    NSArray *confs;
    BOOL showMenuConf;
}
@end

@implementation MenuViewController

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
    
    IConfs *app = [[IConfs alloc] init];
    [app fetchConferences];
    
    menuGen = [[NSArray alloc] initWithObjects:@"Manage Conferences", @"Personal Agenda", nil];
    menuConf = [[NSArray alloc] initWithObjects:@"Sessions",@"Speakers",@"Locations",@"Where am I?",@"Shedule", nil];
    confs = [[NSArray alloc] initWithArray:[app getMyConferences]];
    
    [[self slidingViewController] setAnchorRightPeekAmount:450.0f];
    [[self slidingViewController] setUnderLeftWidthLayout:ECFullWidth];
    
    showMenuConf = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    else if ([indexPath section] == 1)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [menuConf objectAtIndex:[indexPath row]]];
    else if ([indexPath section] == 2)
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [((Conference*)[confs objectAtIndex:[indexPath row]]) getName]];
    
    
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *str;
    //UITableViewCell *cell = [self.MenuView cellForRowAtIndexPath:indexPath];
    
    NSString *iD = [NSString stringWithFormat:@"%@", [self.MenuView cellForRowAtIndexPath:indexPath].textLabel.text];
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    if ([indexPath section] == 0){
        showMenuConf = NO;
        [[self MenuView] deselectRowAtIndexPath:indexPath animated:NO];
        
        [[self slidingViewController] anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
            [[self slidingViewController] setTopViewController:newTopViewController];
            [[[[self slidingViewController] topViewController] view] setFrame:frame];
            [[self slidingViewController] resetTopView];
        }];
    }else if ([indexPath section] == 1){
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
        [self.MenuView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (IBAction)homeButtonPressed:(id)sender {
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Home"];
    
    [[self slidingViewController] anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        [[self slidingViewController] resetTopView];
    }];
}
@end
