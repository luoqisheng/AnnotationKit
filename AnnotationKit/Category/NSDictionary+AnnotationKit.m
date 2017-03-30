//
//  NSDictionary+AnnotationKit.m
//  AnnotationKit
//
//  Created by luoqihsneg on 2016/11/23.
//  Copyright © 2016年 com.luoqihsneg. All rights reserved.
//

#import "NSDictionary+AnnotationKit.h"

@implementation NSDictionary (AnnotaionKit)
- (id)akSafeObjectForKey:(NSString *)key{
    id value = [self objectForKey:key];
    if([value isKindOfClass:[NSNull class]]){
        value = nil;
    }
    return value;
}
@end
