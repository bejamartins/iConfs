//
//  Paper.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 21/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paper: NSObject
{
    @protected
    int paperID;
    NSString* title;
    NSArray* authors;
    NSString* abstract;
    NSString* link;
}

//Paper ID
@property (nonatomic) int paperID;

//Paper's title'
@property (nonatomic) NSString* title;

//Paper's authors
@property (nonatomic) NSArray* authors;

//Papers abstract
@property (nonatomic) NSString* abstract;

//Paper's link
@property (nonatomic) NSString* link;

/**
 Initializes a new Paper object
 @param pID paper ID
 @param t paper title
 @param a authors list
 @param ab paper's abstract
 @param l paper's link
 @returns a newly initialized object
 */
-(Paper*)initWithData: (int) pID title:(NSString*) t authors: (NSArray*) a abstract:(NSString*)ab link:(NSString*) l;

/**
 Gets the paper's title
 @returns the paper's title
 */
-(NSString*)getTitle;

/**
 Gets the paper's authors
 @returns the paper's authors
 */
-(NSArray*)getAuthors;

/**
 Gets the paper's abstract
 @returns the paper's abstract
 */
-(NSString*)getAbstract;

/**
 Gets the paper's ID
 @returns the paper's ID
 */
-(int)getID;

/**
 Gets the paper's Link
 @returns the paper's Link
 */
-(NSString*)getLink;

@end
