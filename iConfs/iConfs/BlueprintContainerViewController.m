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
    
    for(int i=0; i< [self.placesToShow count];i++){
        Place *p= [self.placesToShow objectAtIndex:i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake([p getX],[p getY], 30, 20)];
        UIImage *graphImage = [[UIImage alloc] initWithContentsOfFile: [p getLogo]];
        [imgView setImage:graphImage];
    }
    
    
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
}



@end
