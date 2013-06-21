//
//  PersonViewController.m
//  iConfs
//
//  Created by Ana T on 04/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PersonViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface PersonViewController (){
    NSString *confID;
}

@property (weak, nonatomic) IBOutlet UIButton *PaperButton;
@property (weak, nonatomic) IBOutlet UILabel *WhenLabel;
@property (weak, nonatomic) IBOutlet UILabel *WhereLabel;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;


@end

@implementation PersonViewController

@synthesize picture,biography,IndexAux,showPerson, MenuButton, shownPerson, PaperButton;

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
    
    confID = [[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] getID];
    
    [[[self NavBar] topItem] setTitle:[shownPerson getName]];
    [picture setImage:[[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf] loadImage:confID :[shownPerson getImagePath]]];
    [biography setText:[shownPerson getWork]];
    
    if ([shownPerson isKindOfClass:[Speaker class]])
        [PaperButton setHidden:YES];
    
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

- (IBAction)viewPaper:(id)sender {
    (Author*)shownPerson;
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Person"];
    
    [[self slidingViewController] setTopViewController:newTopViewController];
}
@end
