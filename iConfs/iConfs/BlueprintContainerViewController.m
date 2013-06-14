//
//  BlueprintContainerViewController.m
//  iConfs
//
//  Created by Ana T on 13/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "BlueprintContainerViewController.h"

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) changeBlueprint:(Blueprints*)prints{
    self.blueprints=prints;
}

@end
