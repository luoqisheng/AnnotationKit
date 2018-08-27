//
//  AnnotationMacro.h
//  Annotation
//
//  Created by luoqihsneg on 2016/11/5.
//  Copyright © 2016年 com.luoqihsneg. All rights reserved.
//

#ifndef AnnotationMacro_h
#define AnnotationMacro_h
#include "metamacro.h"

#define NameGen(cls) metamacro_concat(cls, __COUNTER__)

#ifndef SEG_PHET
#define SEG_PHET   SEG_DATA
#endif

#ifndef AnnotationDATA
#define AnnotationDATA(sectName) __attribute((used, section("__DATA,"#sectName" "), no_sanitize_address))
#endif

#endif /* AnnotationMacro_h */
