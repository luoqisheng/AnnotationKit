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
#define RequestMapping(cls,url) \
class AKEngine; char *const NameGen(cls) AnnotationDATA(route) = "{\""#cls"\":"#url"}";
#endif

#ifndef AKNPC
#define AKNPC(cls,sel,url) \
class AKEngine; char *const NameGen(cls) AnnotationDATA(npc) = "{\"cls_name\":\""#cls"\",\"sel_name\":\""#sel"\",\"url\":"#url"}";
#endif

@interface AKRouteAnnotation : PHAnnotationHandler
@end

@interface AKNPCAnnotation : PHAnnotationHandler
@end
