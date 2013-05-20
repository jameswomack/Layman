//
//  NSArray+Any.h
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGAnyProxy : NSProxy
@property (nonatomic, unsafe_unretained) NSArray *array;
@end

@interface NSArray (Any)
@property (nonatomic, strong, readonly) id any;
@end
