//
//  ManageViewController.m
//  iConfs
//
//  Created by Jareth on 5/29/13.
//  Copyright (c) 2013 Jareth. All rights reserved.
//

#import "ManageViewController.h"
#import "ManageConfCell.h"
#import "IConfs.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface ManageViewController ()
{
    NSArray *myConfs;
    NSArray *otherConfs;
    IConfs *Main;
}
@end

@implementation ManageViewController

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
    
    Main = [IConfs alloc];
    myConfs = [NSArray alloc];
    otherConfs = [NSArray alloc];
    
    if (![Main fetchConferences]) {
        [[self VerifyButton] setHidden:YES];
        [[self VerifyButton] setUserInteractionEnabled:NO];
    }
    myConfs = [Main getAllConferences];
    otherConfs = [Main getRestOfConfs];
    
    //myConfs = [[NSArray alloc] initWithObjects:@"conf.jpg", @"conf.jpg", @"conf.jpg", @"conf.jpg", nil];
    //otherConfs = [[NSMutableArray alloc] initWithObjects:@"2.jpg", @"2.jpg", nil];
    
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [[self slidingViewController] setUnderLeftViewController:[[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"]];
        
        [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        //[[cell IconConf] setImage:[UIImage imageNamed:[myConfs objectAtIndex:[indexPath row]]]];
        //[[cell LabelConf] setText:[myConfsName objectAtIndex:[indexPath row]]];
    }else{
        
        [[cell IconConf] setImage:[((Conference*)[otherConfs objectAtIndex:[indexPath row]]) getLogo]];
        [[cell LabelConf] setText:[((Conference*)[otherConfs objectAtIndex:[indexPath row]]) getName]];
        
        //[[cell IconConf] setImage:[UIImage imageNamed:[otherConfs objectAtIndex:[indexPath row]]]];
        //[[cell LabelConf] setText:[otherConfsName objectAtIndex:[indexPath row]]];
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
}

- (IBAction)remConfs:(id)sender {
}

@end
