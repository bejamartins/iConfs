//
//  Person.h
//  iConfs3
//
//  Created by Eduardo Joel Pereira Beja Martins on 20/05/13.
//  Copyright (c) 2013 G10PI. All rights reserved.
//

#ifndef iConfs3_Person_h
#define iConfs3_Person_h

#import <Foundation/Foundation.h>

#import <Foundation/NSObject.h>

@interface Person: NSObject
{
@protected
    NSString *name;
    NSString *work;
    NSString *imagePath;
    NSInteger personID;
}

//Name of the person
@property (nonatomic) NSString* name;

//Proffession of the persion
@property (nonatomic) NSString* work;

//Path to the image of the person
@property (nonatomic) NSString* imagePath;

//Person ID
@property (nonatomic) int personID;

/**
 Initializes a new Person object
 @param n name of the person
 @param h the person's profession
 @param imgPath the path to the person's picture
 @param pID person's ID
 @returns a newly initialized object
 */
-(Person*)initWithData: (NSString*) n work: (NSString*) h image:(NSString*)imgPath personID: (int)pID;

/**
 Gets the person's name
 @returns person's name
 */
-(NSString*)getName;

/**
 Gets the person's profession
 @returns person's profession
 */
-(NSString*)getWork;

/**
 Gets the person's image path
 @returns person's image path
 */
-(NSString*)getImagePath;

/**
 Gets the person's ID
 @returns person's ID
 */
-(int)getID;
@end



#endif
