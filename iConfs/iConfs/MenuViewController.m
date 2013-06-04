//
//  MenuViewController.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"

@interface MenuViewController ()
{
    NSArray *menu;
    NSString *selectedConf;
    NSMutableArray *confs;
    NSArray *menuGen;
    NSArray *menuConf;
    bool showMenuConf;
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
    
    confs = [[NSMutableArray alloc]initWithObjects:@"Conf 1",@"Conf 2", nil];
    menuGen = [[NSArray alloc]initWithObjects:@"Manage Conferences",@"My Conferences", @"Personal Agenda", nil];
    menuConf = [[NSArray alloc]initWithObjects:@"Sessions",@"Speakers",@"Locations",@"Where am I?",@"Shedule", nil];
    
    menu = [[NSArray alloc]initWithObjects:@"Home", @"ManageConf", nil];
    
    [[self slidingViewController] setAnchorRightPeekAmount:200.0f];
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
        cell.textLabel.text = menuGen[indexPath.row];
    else if ([indexPath section] == 1)
        cell.textLabel.text = menuConf[indexPath.row];
    else if ([indexPath section] == 2)
        cell.textLabel.text = confs[indexPath.row];
    
    
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *str;
    //UITableViewCell *cell = [self.MenuView cellForRowAtIndexPath:indexPath];
    
    NSString *iD = [NSString stringWithFormat:@"%@", [self.MenuView cellForRowAtIndexPath:indexPath].textLabel];
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    [[self slidingViewController] anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
        [[self slidingViewController] setTopViewController:newTopViewController];
        [[[[self slidingViewController] topViewController] view] setFrame:frame];
        [[self slidingViewController] resetTopView];
    }];
    
/*    if ([indexPath section] == 0){
        str = [[cell textLabel] text];
        showMenuConf = NO;
        [self.MenuView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }else if ([indexPath section] == 1){
        str = [[cell textLabel] text];
        [self performSegueWithIdentifier:@"SpeakersSegue" sender:@"Speakers"];
    }else{
        selectedConf = [[cell textLabel] text];
        showMenuConf = YES;
        [self.MenuView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    }*/
}

@end
