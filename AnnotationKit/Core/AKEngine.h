//
//  AKEngine.h
//  AnnotationKit
//
//  Created by luoqihsneg on 2016/11/23.
//  Copyright © 2016年 com.luoqihsneg. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "AnnotationMacro.h"
#import "PHAnnotationHandler.h"
#import <UIKit/UIKit.h>

#ifndef DefineAnnotation /*use @DefineAnnotation() to declare your custom annotation  */

#define AnnotationSectName "annotation"
#define DefineAnnotation(handler,section) \
class AKEngine; char * const NameGen(handler,annotation) AnnotationDATA(annotation) = "{\""#handler"\":\""#section"\"}";
#endif


@interface AKEngine : NSObject

@property(nonatomic,copy)NSDictionary    *launchOptions;
@property(nonatomic,strong)UIApplication *application;

+ (AKEngine *)sharedAKEngine;

- (void)setUp;

@end
