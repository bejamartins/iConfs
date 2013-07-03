//
//  PDFReader.m
//  iConfs
//
//  Created by Ana T on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PDFReader.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"


@interface PDFReader (){
    NSString *path;
    MenuViewController *menu;

}

@end

@implementation PDFReader

@synthesize webview,BackButton,HomeButton,MenuButton,fullView,previous,ConferenceHome;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        fullView =false;
    }
    return self;
}

- (void)viewDidLoad
{
    
    if(self.auxPath!=nil){
    path=[[NSBundle mainBundle] pathForAuxiliaryExecutable:self.auxPath];
    
    [super viewDidLoad];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
	[webview setScalesPageToFit:YES];
    // Do any additional setup after loading the view.

    }
    
    if(fullView){
    
        
          menu=(MenuViewController*)[[self slidingViewController] underLeftViewController] ;
        
    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
    }
        
        
  //  [[self view] addGestureRecognizer:[self slidingViewController].panGesture];
    
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
    
    
    
    [self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
    
    [BackButton setFrame:CGRectMake(717, 4, 43, 40)];
    [BackButton setBackgroundImage:[UIImage imageNamed:@"back3.png"] forState:UIControlStateNormal];
    [BackButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:BackButton];
        
        
        [self setConferenceHome:[UIButton buttonWithType:UIButtonTypeCustom]];
        
        [ConferenceHome setFrame:CGRectMake(660, 4, 43, 40)];
        [ConferenceHome setBackgroundImage:[UIImage imageNamed:@"white_home_conf2.png"] forState:UIControlStateNormal];
        [ConferenceHome addTarget:self action:@selector(goToConferenceHome:) forControlEvents:UIControlEventTouchUpInside];
        
        [[self view] addSubview:ConferenceHome];

    }
    
    
    }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePath:(NSString*)p{
    self.auxPath=p;
}

- (IBAction)goHome:(id)sender{
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    [(MenuViewController*)[[self slidingViewController] underLeftViewController] deselectConf];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
}

- (IBAction)revealMenu:(id)sender
{
    [[self slidingViewController] anchorTopViewTo:ECRight];
}
- (IBAction)goBack:(id)sender{
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:previous];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
    
}

- (void)changePrevious:(UIViewController*)vc{
    
    previous=vc;
    
}
-(void)changeToFullScreen{
    fullView =YES;

}




@end
