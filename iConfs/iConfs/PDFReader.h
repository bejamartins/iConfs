//
//  PDFReader.h
//  iConfs
//
//  Created by Ana T on 11/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFReader : UIViewController{
   
    NSString *path;

}
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end
