
//
//  RHCoding.h
//  特洛伊
//
//  Created by liurihua on 15/9/9.
//  Copyright © 2015年 刘日华. All rights reserved.
//

#ifndef RHCoding_h
#define RHCoding_h


#endif /* RHCoding_h */

#import <objc/runtime.h>

#define RHCoding \
\
- (id)initWithCoder:(NSCoder *)aDecoder{ \
    \
    if (self = [super init]) {\
        \
        Class c = self.class;\
        \
        while (c && c != [NSObject class]){\
            \
            unsigned int count = 0;\
            \
            Ivar *ivars = class_copyIvarList(c, &count);\
            \
            for (int i = 0; i < count; i++) {\
                \
                NSString *key = [NSString stringWithUTF8String:ivar_getName(ivars[i])];\
                \
                id value = [aDecoder decodeObjectForKey:key];\
                \
                [self setValue:value forKey:key];\
                \
            }\
            \
            c = [c superclass];\
            \
            free(ivars);\
        }\
    }\
    \
    return self;\
}\
\
\
\
- (void)encodeWithCoder:(NSCoder *)aCoder{\
    \
    Class c = self.class;\
    \
    while (c && c != [NSObject class]) {\
        \
        unsigned int count = 0;\
        \
        Ivar *ivars = class_copyIvarList(c, &count);\
        \
        for (int i = 0; i < count; i++) {\
            \
            Ivar ivar = ivars[i];\
            \
            NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];\
            \
            id value = [self valueForKey:key];\
            \
            [aCoder encodeObject:value forKey:key];\
            \
        }\
        \
        c = [c superclass];\
        \
        free(ivars);\
    }\
}\
