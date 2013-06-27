//
//  ConferenceScreenViewController.m
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "ConferenceScreenViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "Conference.h"
#import "Notification.h"
#import "NewsViewController.h"

@interface ConferenceScreenViewController (){
    Conference *conf;
    NSUInteger currentNotIndex;
    Notification *currentNotification;
    NSInteger numberOfNots;
    NSArray *notifications;
    NSMutableArray *newsToShow;
    int currentNewsIndex;
      MenuViewController *menu;



    

}
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
//@property (strong, nonatomic) IBOutlet UINavigationItem *bar;
@property (strong, nonatomic) IBOutlet UIButton *backbutton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ConferenceScreenViewController
@synthesize conferenceName;
@synthesize MenuButton,notification_number,notification_title,Notification_text,date,title,picture,HomeButton;







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
    //NSLog(@"Name em ConferenceScreen= %@", conferenceName);
  
    
    
    [super viewDidLoad];

    
    if(conf==nil){
        conf=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];
        
        
          menu=(MenuViewController*)[[self slidingViewController] underLeftViewController] ;

        
        newsToShow=[[NSMutableArray alloc] init];

        notifications=[conf getNotifications];
        numberOfNots=[notifications count];
        currentNotIndex=numberOfNots-1;
        currentNotification=[notifications objectAtIndex:currentNotIndex];
        [self.forwardButton setEnabled:NO];
        
        conferenceName=  [conf getName];
        [[ self bar] setTitle:conferenceName];
        
        if(currentNotIndex==0){
            [self.backbutton setEnabled:NO];
        }

    }
    
    
    
    

	// Do any additional setup after loading the view.
    
    [notification_title setText:[currentNotification getTitle]];
     [Notification_text setText:[currentNotification getText]];
    NSString *totalNotifications = [NSString stringWithFormat:@"%i", numberOfNots];
    NSString *numberCurrentNotification = [NSString stringWithFormat:@"%i",currentNotIndex+1 ];
    NSString *notificationNumb=[NSString stringWithFormat:@"%@/%@",numberCurrentNotification,totalNotifications];
    [notification_number setText:notificationNumb];
 
    
    NSDate *notDate=[currentNotification getDate];
    NSString *stringDate=(NSString *)notDate;
    [self.date setText:stringDate];

    [[[self view] layer] setShadowOpacity:0.75f];
    [[[self view] layer] setShadowRadius:10.0f];
    [[[self view] layer] setShadowColor:[UIColor blackColor].CGColor];
    
    if (![[[self slidingViewController] underLeftViewController] isKindOfClass:[MenuViewController class]]) {
        [self slidingViewController].UnderLeftViewController = [[self storyboard]instantiateViewControllerWithIdentifier:@"Menu"];
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
    


    
    NSArray *news=[[NSArray alloc] init];
    
    news=[conf getNews];
    NSString* tAux;
    int size= [news count];
    int counter=0;
    
    
    
    if(size>=3){
    for(int i =size-1; i>size-4;i--){
        News *n=[news objectAtIndex:i];
        [newsToShow insertObject:n atIndex:counter];
        counter++;
        
    }
        News *n= [newsToShow objectAtIndex:currentNewsIndex];
        
        //ALTERAR
        [picture setImage:[UIImage imageNamed:@"conf.jpg"]];
        
        
        [title setText:[n getTitle]];
    }
    else if(size!=0){
    
        for (int i=size-1; i>=0;i--) {
            
            News *n=[news objectAtIndex:i];
            [newsToShow insertObject:n atIndex:counter];
            counter++;

        
        
        }
        
        [self.pageControl setNumberOfPages:size];
        News *n= [newsToShow objectAtIndex:currentNewsIndex];
        
        //ALTERAR
        [picture setImage:[UIImage imageNamed:@"conf.jpg"]];
        
        
        [title setText:[n getTitle]];
    }
    else{
         tAux = [NSString stringWithFormat:@"Welcome To %@ iConfs page!",[conf getName]];
      
                                                       
       [picture setImage:[conf getLogo]];
        [title setText:tAux];
         [self.pageControl setNumberOfPages:1];
    }
    
    
    
    NSLog(@"valor do index %d",currentNewsIndex);
    
    
    
    
    //VERIFICAR SE TEM IMAGEM!
    
    
    
  
    
    

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

-(void)changeName:(NSString *)name{
    conferenceName=name;
    [[ self bar] setTitle:conferenceName];
    
    
}

- (IBAction)forwardButton:(id)sender {
    
        currentNotIndex++;
    if(currentNotIndex==(NSInteger)1){
        [self.backbutton setEnabled:YES];

    }
        currentNotification=[notifications objectAtIndex:currentNotIndex];

        [self viewDidLoad];
    if(currentNotIndex==(NSInteger)numberOfNots-1){
        [self.forwardButton setEnabled:NO];
}
}
- (IBAction)backButton:(id)sender {
    currentNotIndex--;
    currentNotification=[notifications objectAtIndex:currentNotIndex];
    [self.forwardButton setEnabled:YES];
    [self viewDidLoad];
    
    if(currentNotIndex==0){
        [self.backbutton setEnabled:NO];

    
}
    
    
    }
-(Conference*) getConference{

           Conference *c=[(MenuViewController*)[[self slidingViewController] underLeftViewController] selectedConf];

    return c;
}

- (IBAction)changeNews:(UIPageControl *)sender {
    
    
    NSLog(@"entrei no changeNews!");
    
    if(sender.numberOfPages!=1){
    News *n= [newsToShow objectAtIndex:sender.currentPage];
    //TODO: mudar!
    [picture setImage:[UIImage imageNamed:@"conf.jpg"]];
    
    [title setText:[n getTitle]];
    currentNewsIndex=sender.currentPage;
        NSLog(@"valor do index %d",currentNewsIndex);

    }
}
- (IBAction)openNews:(id)sender{

    
    NSString *iD = @"News";
    
    NSArray *news=[conf getNews];
    NewsViewController *newTopViewController =[[self storyboard]instantiateViewControllerWithIdentifier:iD];
    NSLog(@"valor do index openNews %d",currentNewsIndex);
    NSLog(@"tITULO DA NOTICIA: %@",[[news objectAtIndex:currentNewsIndex]getTitle]);
    NSArray *aux=[NSArray arrayWithObject:[newsToShow objectAtIndex:currentNewsIndex]];
    
    [newTopViewController changeNews:aux];
    [newTopViewController changePrevious:self];
    [newTopViewController viewDidLoad];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];

    
    
    
}
- (IBAction)goHome:(id)sender{
    
    
    NSString *iD = @"Home";
    
    UIViewController *newTopViewController = [[self storyboard]instantiateViewControllerWithIdentifier:iD];
    
    [(MenuViewController*)[[self slidingViewController] underLeftViewController] deselectConf];
    
    CGRect frame = [[[[self slidingViewController] topViewController] view] frame];
    [[self slidingViewController] setTopViewController:newTopViewController];
    [[[[self slidingViewController] topViewController] view] setFrame:frame];
}



@end
