//
//  Conference-News.m
//  iConfs
//
//  Created by Ana T on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "Conference-News.h"
#import "CellNewsInsideConference.h"
#import "Conference.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "News.h"
#import "ConferenceScreenViewController.h"
@interface Conference_News (){
    Conference *conf;
    NSMutableArray *newsToShow;
    int currentNewsIndex;

}

@end

@implementation Conference_News
@synthesize picture,title;
- (void)viewDidLoad{

    
    if(conf==nil){
        ConferenceScreenViewController *VC=(ConferenceScreenViewController*)self.parentViewController;
        
        UIViewController *X=self.parentViewController;

        conf=[VC getConference];
        newsToShow=[[NSMutableArray alloc] init];

        NSString *confName=[conf getName];
        NSString *random=@"shdsad";
    }
    NSArray *news=[[NSArray alloc] init];
    news=[conf getNews];
    
    int size= [news count];
    int counter=0;
    
    for(int i =size-1; i>size-4;i--){
        News *n=[news objectAtIndex:i];
        [newsToShow insertObject:n atIndex:counter];
        counter++;
    
    }
    NSLog(@"valor do index %d",currentNewsIndex);

    
    
    News *n= [newsToShow objectAtIndex:currentNewsIndex];
    
    //VERIFICAR SE TEM IMAGEM!
    
    
    
    [picture setImage:[UIImage imageNamed:@"conf.jpg"]];
    
    [title setText:[n getTitle]];
    



}




- (IBAction)changeNews:(UIPageControl *)sender {
    
    NSLog(@"entrei no chanfeNews!");
    
    News *n= [newsToShow objectAtIndex:sender.currentPage];
    //TODO: mudar!
    [picture setImage:[UIImage imageNamed:@"conf.jpg"]];
    
    [title setText:[n getTitle]];
    currentNewsIndex=sender.currentPage;
}


@end
