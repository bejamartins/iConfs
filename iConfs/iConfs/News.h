//
//  News.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 18/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#ifndef iConfs3_News_h
#define iConfs3_News_h

@interface News: NSObject
{
@protected
    NSString* title;
    NSString* text;
    NSDate* sentDate;
}

//News title
@property (nonatomic) NSString* title;

//News text
@property (nonatomic) NSString* text;

//News sent date
@property (nonatomic) NSDate* sentDate;

/**
 Initializes a new News object
 @param t title of the news
 @param txt text of the news
 @param date sent date of the news
 @returns a newly initialized object
 */
-(News*)initWithData: (NSString*) t text: (NSString*) txt date:(NSDate*)date;

/**
 Gets the news title
 @returns news title
 */
-(NSString*)getTitle;

/**
 Gets the news text
 @returns news text
 */
-(NSString*)getText;

/**
 Gets the news date
 @returns news date
 */
-(NSDate*)getDate;

@end



#endif
