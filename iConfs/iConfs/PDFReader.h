//
//  PDFReader.h
//  iConfs
//
//  Created by Ana T on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFReader : UIViewController{
   

}
@property (strong, nonatomic) IBOutlet UIWebView *webview;
@property NSString *auxPath;
@property (strong, nonatomic) UIButton *HomeButton;
@property BOOL fullView;
@property (strong, nonatomic) UIButton *BackButton;
@property (strong, nonatomic) UIButton *MenuButton;
@property UIViewController *previous;

@property (strong, nonatomic) UIButton *ConferenceHome;


- (void)changePrevious:(UIViewController*)vc;
-(void)changePath:(NSString*)p;
-(void)changeToFullScreen;

@end
