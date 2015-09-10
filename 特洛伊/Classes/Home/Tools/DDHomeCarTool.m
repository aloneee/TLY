//
//  DDHomeCarTool.m
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#import "DDHomeCarTool.h"
#import "DDHomeCar.h"

#define DDHomeCarFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carFile.data"]

@implementation DDHomeCarTool

SingletonM(DDHomeCarTool)

+ (void)saveCar:(DDHomeCar *)car
{
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self getCars]];
    
    [array addObject:car];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 存进沙盒
        [NSKeyedArchiver archiveRootObject:[array copy] toFile:DDHomeCarFile];
        
    });
}

+ (NSMutableArray *)getCars;
{
    if (![NSKeyedUnarchiver unarchiveObjectWithFile:DDHomeCarFile]){
        
        return [NSMutableArray array];
    }
    
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:DDHomeCarFile];
}

+ (void)removeCar:(DDHomeCar *)car
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:DDHomeCarFile])
    {

        [[self getCars] enumerateObjectsUsingBlock:^(DDHomeCar* c, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([car isEqual:c]) {
                [[self getCars] removeObject:c];
                *stop = YES;
            }
        }];
        
        [NSKeyedArchiver archiveRootObject:[self getCars] toFile:DDHomeCarFile];
    }
}

@end
