//
//  BlueprintContainerViewController.m
//  iConfs
//
//  Created by Ana T on 13/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "BlueprintContainerViewController.h"
#import "Place.h"
@interface BlueprintContainerViewController ()

@end

@implementation BlueprintContainerViewController
@synthesize blueprint,image;

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
    //vai colocar os places! pq a planta é posta no changeBlueprint
  
    
    [blueprint setImage:image];
    NSInteger height= self.blueprint.frame.size.height;
    NSInteger width=self.blueprint.frame.size.width;

    for(int i=0; i< [self.placesToShow count];i++){
        Place *p= [self.placesToShow objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake([p getX]*width/100,[p getY]*height/100, 100, 100)];
        UIImage *graphImage = [UIImage imageNamed:@"pin.png"];
        [imgView setImage:graphImage];
        [self.view addSubview:imgView];
         imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];
         graphImage = [UIImage imageNamed:@"pin.png"];
        [imgView setImage:graphImage];
        [self.view addSubview:imgView];
        [self.view setNeedsDisplay];


        
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];

    UIImage *graphImage = [UIImage imageNamed:@"pin.png"];
    [imgView setImage:graphImage];
    [self.view addSubview:imgView];
    [self.view setNeedsDisplay];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) changeBlueprint:(UIImage*)print{
    [self.blueprint setImage:print];
    [self viewDidLoad];
    //  TODO: confirmar
}

-(void) changePlaces:(NSArray*) places{

    self.placesToShow=places;
    NSInteger height= self.blueprint.frame.size.height;
    NSInteger width=self.blueprint.frame.size.width;
    for(int i=0; i< [self.placesToShow count];i++){
        Place *p= [self.placesToShow objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake([p getX]*width/100,[p getY]*height/100, 100, 100)];
        UIImage *graphImage = [UIImage imageNamed:@"pin.png"];
        [imgView setImage:graphImage];
        [self.view addSubview:imgView];
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];
        graphImage = [UIImage imageNamed:@"pin.png"];
        [imgView setImage:graphImage];
        [self.view addSubview:imgView];
        [self.view setNeedsDisplay];
        
        
        
    }

}




@end
