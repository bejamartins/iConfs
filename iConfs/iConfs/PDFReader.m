//
//  PDFReader.m
//  iConfs
//
//  Created by Ana T on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "PDFReader.h"

@interface PDFReader (){
    NSString *path;
}

@end

@implementation PDFReader

@synthesize webview;

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
    
    
    path=[[NSBundle mainBundle] pathForAuxiliaryExecutable:self.auxPath];
    
    [super viewDidLoad];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    [webview loadRequest:request];
	[webview setScalesPageToFit:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changePath:(NSString*)p{
    self.auxPath=p;
}

@end
