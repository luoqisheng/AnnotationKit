//
//  PHAnnotationHandler.h
//  Pods
//
//  Created by luoqihsneg on 2017/1/13.
//
//

#import <Foundation/Foundation.h>

@interface PHAnnotationHandler : NSObject

+ (instancetype)shared;

- (instancetype)init NS_UNAVAILABLE;

//need be override
- (void)handleAnnotationConfig:(NSArray<NSString *>*)configs;
@end
