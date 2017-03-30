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

#ifndef AsanGen
#define AsanGen     __asan_gen_ /*used this prefix for global var to ignore address sanitizer */
#endif


#define NameGen(...)   metamacro_concat(AsanGen,NameGen_(__VA_ARGS__))
#define NameGen_(...)  metamacro_concat( metamacro_concat_args , metamacro_argcount(__VA_ARGS__))(__VA_ARGS__)
#define metamacro_concat_args1(...) metamacro_at(0,__VA_ARGS__)
#define metamacro_concat_args2(...) metamacro_concat(metamacro_at(0,__VA_ARGS__),metamacro_at(1,__VA_ARGS__))
#define metamacro_concat_args3(...) metamacro_concat(metamacro_concat_args2(__VA_ARGS__),metamacro_at(2,__VA_ARGS__))



#ifndef SEG_PHET
#define SEG_PHET   SEG_DATA
#endif

#ifndef AnnotationDATA
#define AnnotationDATA(sectName) __attribute((used, section("__DATA,"#sectName" ")))
#endif

#endif /* AnnotationMacro_h */
