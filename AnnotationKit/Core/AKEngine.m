//
//  AKEngine.m
//  AKEngine
//
//  Created by luoqihsneg on 2016/11/23.
//  Copyright © 2016年 luoqihsneg. All rights reserved.
//

#import "AKEngine.h"
#include <mach-o/getsect.h>
#include <mach-o/loader.h>
#include <mach-o/dyld.h>
#include <dlfcn.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import <Foundation/Foundation.h>
#import "NSDictionary+AnnotationKit.h"
#include "AnnotationMacro.h"
#import "PHAnnotationHandler.h"

#ifndef __LP64__

typedef struct mach_header mach_header_t;
typedef struct section     section_t;
#define getsectbynamefromheader getsectbynamefromheader

#else

typedef struct mach_header_64 mach_header_t;
typedef struct section_64     section_t;
#define getsectbynamefromheader getsectbynamefromheader_64
#endif

static NSMutableArray<NSDictionary *> *_annotations = nil;
NSArray<NSString *>* annotation_read_content(const char *sectionName,const mach_header_t *header){
    
    NSMutableArray *configs = [NSMutableArray array];
    const mach_header_t *mhp = header;
    Dl_info info;
    if (mhp == NULL) {
        dladdr(annotation_read_content, &info);
        mhp = (const mach_header_t*)info.dli_fbase;
    }
    unsigned long size = 0;
    uintptr_t *memory = (uintptr_t*)getsectiondata(mhp, SEG_PHET, sectionName, & size);
    unsigned long counter = size/sizeof(void*);
    for(int idx = 0; idx < counter; ++idx){
        char *string = (char*)memory[idx];
        NSString *str = [NSString stringWithUTF8String:string];
        if(!str)continue;
        
        NSLog(@"config = %@", str);
        if(str) [configs addObject:str];
    }

    return configs;
}


static void prepare_annotation(const struct mach_header *header,
                            intptr_t slide)
{
 
    
    for (NSDictionary *map in _annotations) {
        
        if ([map isKindOfClass:[NSDictionary class]] && [map allKeys].count) {
            NSString *sectionName = [[map allKeys] firstObject];
            const char *sectionCName = [sectionName UTF8String];
            const section_t *sect = getsectbynamefromheader((const mach_header_t *)header, SEG_PHET, sectionCName);
            if (!sect || sect->size <= 0) {
                continue;
            }
            
            NSString *handler     = [map akSafeObjectForKey:sectionName];
            Class handlerClass = NSClassFromString(handler);
            NSArray<NSString *>*configs = annotation_read_content(sectionCName,(const mach_header_t *)header);
            if (handlerClass && [handlerClass isSubclassOfClass:[PHAnnotationHandler class]]) {
                
                __kindof PHAnnotationHandler *annotation = [handlerClass shared];
                [annotation handleAnnotationConfig:configs];
                
            }
        }
        
        
    }
}


@implementation AKEngine

+ (id)sharedAKEngine
{
    static AKEngine *engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[AKEngine alloc]init];
    });
    return engine;
}

- (void)setUp
{
    _annotations = [NSMutableArray array];
    mach_header_t *mhp = NULL;
    Dl_info info;
    if (mhp == NULL) {
        dladdr(annotation_read_content, &info);
        mhp = (mach_header_t*)info.dli_fbase;
    }

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *annotations = annotation_read_content(AnnotationSectName,mhp);
        for (NSString *map in annotations) {
            NSData *jsonData =  [map dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            id json = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            if (!error) {
                
                if ([json isKindOfClass:[NSDictionary class]] && [json allKeys].count) {
                    NSString *handler = [[json allKeys] firstObject];
                    NSString *sectionName = [json akSafeObjectForKey:handler];
                    
                    
                    if (handler && sectionName) {
                        [_annotations addObject:@{sectionName:handler}];
                    }
                }
                
            }
        }

    });
    
    if (_annotations.count) {
        //register callback for image additions
        _dyld_register_func_for_add_image(prepare_annotation);
    }
}

@end

