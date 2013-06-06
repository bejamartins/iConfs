//
//  MemoryManager.h
//  iConfs
//
//  Created by Eduardo Joel Pereira Beja Martins on 06/06/13.
//  Copyright (c) 2013 Eduardo Joel Pereira Beja Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IConfs.h"

@interface MemoryManager : NSObject{
    @protected
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    NSString *dataFilePath;
    IConfs* ic;
}

-(MemoryManager*)initMem;
-(IConfs*)getSavediConfs;
-(void)saveiConfs:(IConfs*)i;

@end
