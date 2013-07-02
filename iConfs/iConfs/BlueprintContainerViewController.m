//
//  BlueprintContainerViewController.m
//  iConfs
//
//  Created by Ana T on 13/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "BlueprintContainerViewController.h"
#import "Place.h"
@interface BlueprintContainerViewController (){

    NSMutableArray *points;
    int imageView;
}

@end

@implementation BlueprintContainerViewController
@synthesize blueprint,image,placesToShow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        imageView =100;
    }
    return self;
}

- (void)viewDidLoad
{
    imageView =100;
    [super viewDidLoad];
    //vai colocar os places! pq a planta é posta no changeBlueprint
    points=[[NSMutableArray alloc]init ];
    [blueprint setImage:image];
    NSInteger height= self.blueprint.frame.size.height;
    NSInteger width=self.blueprint.frame.size.width;
 //   [self changePlaces:placesToShow];
        


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) changeBlueprint:(UIImage*)print{
    [self.blueprint setImage:print];
    [self.view setNeedsDisplay];

  //  [self viewDidLoad];
    //  TODO: confirmar
}

-(void) changePlaces:(NSArray*) places{

    self.placesToShow=places;
    
    for(int j=0; j< [points count];j++){
        UIImageView *iv=(UIImageView*)[points objectAtIndex:j];
        iv.image=nil;
        iv.hidden=YES;
        int tag=iv.tag;
        [[self.view viewWithTag:tag] removeFromSuperview];
        [iv setNeedsDisplay];
        [self.view setNeedsDisplay];
    
    }
    points=[[NSMutableArray alloc] init];
    
    NSInteger height= self.blueprint.frame.size.height;
    NSInteger width=self.blueprint.frame.size.width;
    for(int i=0; i< [self.placesToShow count];i++){
        Place *p= [self.placesToShow objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake([p getX]*width/100,[p getY]*height/100, 100, 100)];
        UIImage *graphImage = [UIImage imageNamed:@"pin.png"];
        [imgView setImage:graphImage];
        [imgView setTag:imageView];
        [points addObject:imgView];
        [self.view addSubview:imgView];
        [self.view setNeedsDisplay];
        imageView ++;
    
        
        
    }

}




@end
