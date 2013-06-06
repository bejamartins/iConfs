//
//  MemoryManager.m
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import "MemoryManager.h"

@implementation MemoryManager


-(MemoryManager*)initMem{
    
    filemgr = [NSFileManager defaultManager];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    dataFilePath = [[NSString alloc] initWithString: [docsDir
                                                      stringByAppendingPathComponent: @"data.archive"]];
    return self;
}

-(IConfs*)getSavediConfs{
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFilePath])
    {
        NSMutableArray *dataArray;
        
        dataArray = [NSKeyedUnarchiver
                     unarchiveObjectWithFile: dataFilePath];
        
        ic = [dataArray objectAtIndex:0];
    }
    return ic;
}

-(void)saveiConfs:(IConfs*)i{
    ic = i;
    NSMutableArray *contactArray;
    
    contactArray = [[NSMutableArray alloc] init];
    [contactArray addObject:ic];
    [NSKeyedArchiver archiveRootObject:
     contactArray toFile:dataFilePath];
}



@end
