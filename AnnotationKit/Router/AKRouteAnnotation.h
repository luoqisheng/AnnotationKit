//
//  AKRouteAnnotaion.h
//  Pods
//
//  Created by luoqihsneg on 2016/11/5.
//
//

#import <Foundation/Foundation.h>
#import "AKEngine.h"

#ifndef RequestMapping
#define RequestMapping(name,url) \
class AKEngine; char *const NameGen(name,_url) AnnotationDATA(route) = "{\""#name"\":"#url"}";
#endif


@interface AKRouteAnnotation : PHAnnotationHandler
@end
