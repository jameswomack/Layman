//
//  NGPropertyManager.h
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#ifndef Layman_NGPropertyManager_h
#define Layman_NGPropertyManager_h

#define NGDynamic(variableName, Type) \
@synthesize variableName = _ ## variableName;\
- (Type *)variableName\
{\
    if (!_ ## variableName)\
    {\
        _ ## variableName = Type.new;\
    }\
    return _ ## variableName;\
}

#endif
