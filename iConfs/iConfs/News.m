//
//  News.m
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 17/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import "News.h"

@implementation News

-(News*)initWithData: (NSString*) t text: (NSString*) txt date:(NSDate*)date{
    self.title = t;
    self.text = txt;
    self.sentDate = date;
    return self;
}
-(NSString*)getTitle{
    return self.title;
}
-(NSString*)getText{
    return self.text;
}
-(NSDate*)getDate{
    return self.sentDate;
}

@end

