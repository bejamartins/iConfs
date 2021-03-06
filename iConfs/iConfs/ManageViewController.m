//
//  ManageViewController.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "ManageViewController.h"
#import "ManageConfCell.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "AppDelegateProtocol.h"
#import "IConfs.h"

@interface ManageViewController ()
{
    NSArray *myConfs;
    NSArray *otherConfs;
    IConfs *theAppData;
}
@end

@implementation ManageViewController

@synthesize MenuButton,HomeButton;

#pragma - Data Fetch Method

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
	// Do any additional setup after loading the view, typically from a nib.
    
    [[self ConfsCollection] setDelegate:self];
    [[self ConfsCollection] setDataSource:self];
    
    [[self AddConfButton] setHidden:YES];
    [[self AddConfButton] setUserInteractionEnabled:NO];
    [[self RemConfButton] setHidden:NO];
    [[self RemConfButton] setUserInteractionEnabled:YES];
    
    theAppData = [self appData];
    
    [theAppData fetchConferences];
    myConfs = [theAppData getMyConferences];
    otherConfs = [theAppData getRestOfConfs];
    
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

#pragma - Collection View Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([[self Options] selectedSegmentIndex] == 0)
        return [myConfs count];
    else
        return [otherConfs count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConfCell";
    
    ManageConfCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell setChecked:NO];
    [[cell CheckButton] setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    
    if (cell == nil) {
        cell = [[ManageConfCell alloc] init];
    }
    
    if ([[self Options] selectedSegmentIndex] == 0) {
        [[cell IconConf] setImage:[((Conference*)[myConfs objectAtIndex:[indexPath row]]) getLogo]];
        [[cell LabelConf] setText:[((Conference*)[myConfs objectAtIndex:[indexPath row]]) getName]];
    }else{
        
        [[cell IconConf] setImage:[((Conference*)[otherConfs objectAtIndex:[indexPath row]]) getLogo]];
        [[cell LabelConf] setText:[((Conference*)[otherConfs objectAtIndex:[indexPath row]]) getName]];
    }
    
    [[cell LabelConf] setTextAlignment:NSTextAlignmentCenter];
    
    return cell;
}

- (IBAction)SelectedOption:(id)sender {
    if ([[self Options] selectedSegmentIndex] == 0) {
        [[self AddConfButton] setHidden:YES];
        [[self AddConfButton] setUserInteractionEnabled:NO];
        [[self RemConfButton] setHidden:NO];
        [[self RemConfButton] setUserInteractionEnabled:YES];
    }else {
        [[self RemConfButton] setHidden:YES];
        [[self RemConfButton] setUserInteractionEnabled:NO];
        [[self AddConfButton] setHidden:NO];
        [[self AddConfButton] setUserInteractionEnabled:YES];
    }
    
    [[self ConfsCollection] reloadData];
}

- (IBAction)addConfs:(id)sender {
    NSString *message=@"The following conferences were added with success: \n";
    NSArray *paths = [[self ConfsCollection] indexPathsForVisibleItems];
    ManageConfCell *cell;
    
    for (int i = 0; i < [paths count]; i++) {
        cell = (ManageConfCell*)[[self ConfsCollection] cellForItemAtIndexPath:[paths objectAtIndex:i]];
        if ([cell checked]) {
            [theAppData addConference:[otherConfs objectAtIndex:[(NSIndexPath*)[paths objectAtIndex:i] row]]];
            message=[NSString stringWithFormat:@"%@%@%@", message,[[otherConfs objectAtIndex:[(NSIndexPath*)[paths objectAtIndex:i] row]]getName],@"\n"];
        }
    }
    
    myConfs = [theAppData getMyConferences];
    otherConfs = [theAppData getRestOfConfs];
    
    [[self ConfsCollection] reloadData];
    [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add Conference"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)remConfs:(id)sender {
    NSArray *paths = [[self ConfsCollection] indexPathsForVisibleItems];
    ManageConfCell *cell;
    NSString *message=@"The following conferences were removed with success: \n";

    for (int i = 0; i < [paths count]; i++) {
        cell = (ManageConfCell*)[[self ConfsCollection] cellForItemAtIndexPath:[paths objectAtIndex:i]];
        if ([cell checked]) {
            message=[NSString stringWithFormat:@"%@%@%@", message,[[myConfs objectAtIndex:[(NSIndexPath*)[paths objectAtIndex:i] row]]getName],@"\n"];
            [theAppData removeConference:[(Conference*)[myConfs objectAtIndex:[(NSIndexPath*)[paths objectAtIndex:i] row]] getID]];

        }
        
    }
    
    myConfs = [theAppData getMyConferences];
    otherConfs = [theAppData getRestOfConfs];
    
    [[self ConfsCollection] reloadData];
    [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];

    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove Conference"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)goHome:(id)sender{
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
    
}

@end
