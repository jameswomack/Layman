//
//  NGLayoutSet.h
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGLayoutSet : NSObject

typedef BOOL (^NGComparisonBlock)(id obj, BOOL *stop);

#define AL_CENTER_X NSLayoutAttributeCenterX
#define AL_TOP NSLayoutAttributeTop
#define AL_WIDTH NSLayoutAttributeWidth
#define AL_HEIGHT NSLayoutAttributeHeight
#define AL_LESS_OR NSLayoutRelationLessThanOrEqual
#define GREATER_OR NSLayoutRelationGreaterThanOrEqual
#define AL_EQUAL NSLayoutRelationEqual

extern NSLayoutConstraint *NGLayoutInSuperview(UIView *view, NSLayoutAttribute attribute, NSLayoutRelation relation, CGFloat constant);
extern NSLayoutConstraint *NGLayoutEqual(UIView *view0, UIView *view1, NSLayoutAttribute attribute);
extern NSLayoutConstraint *NGLayoutFromBottom(UIView *view0, UIView *view1, CGFloat constant);
extern NSLayoutConstraint *NGLayoutAlignRight(UIView *view0, UIView *view1);

@property (nonatomic, strong, readonly) NSMutableSet *layouts;

#pragma mark - Adding Layouts
- (void)addLayouts:(NSSet *)objects;
- (void)addLayout:(NSLayoutConstraint *)layout;

#pragma mark - Removing Layouts
- (void)removeLayout:(NSLayoutConstraint *)layout;
- (void)removeAllLayouts;

#pragma mark - Checking for Membership
- (void)containsLayout:(NSLayoutConstraint *)layout;
- (NSSet *)layoutsWithKey:(NSString *)key andValue:(id)value;

#pragma mark - Counting Layouts
- (NSUInteger)count;

#pragma mark - Applying to views
- (void)applyToView:(UIView *)view;

@end
