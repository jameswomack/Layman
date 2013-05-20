//
//  NGLayoutSet.m
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NGLayoutSet.h"
#import "NGExceptions.h"
#import "NGPropertyManager.h"

@interface NGLayoutSet ()
@property (nonatomic, strong, readwrite) NSMutableSet *layouts;
@end

// Collection of layouts that can be conditionally applied to one or more views
@implementation NGLayoutSet

NGDynamic(layouts, NSMutableSet);

NSLayoutConstraint *NGLayoutInSuperview(UIView *view, NSLayoutAttribute attribute, NSLayoutRelation relation, CGFloat constant)
{
    return [NSLayoutConstraint constraintWithItem:view attribute:attribute relatedBy:relation toItem:view.superview attribute:attribute multiplier:1.f constant:constant];
}

NSLayoutConstraint *NGLayoutEqual(UIView *view0, UIView *view1, NSLayoutAttribute attribute)
{
    return [NSLayoutConstraint constraintWithItem:view0 attribute:attribute relatedBy:AL_EQUAL toItem:view1 attribute:attribute multiplier:1.f constant:0.f];
}

NSLayoutConstraint *NGLayoutFromBottom(UIView *view0, UIView *view1, CGFloat constant)
{
    return [NSLayoutConstraint constraintWithItem:view0 attribute:NSLayoutAttributeTop relatedBy:AL_EQUAL toItem:view1 attribute:NSLayoutAttributeBottom multiplier:1.f constant:constant];
}

NSLayoutConstraint *NGLayoutAlignRight(UIView *view0, UIView *view1)
{
    return [NSLayoutConstraint constraintWithItem:view0 attribute:NSLayoutAttributeRight relatedBy:AL_EQUAL toItem:view1 attribute:NSLayoutAttributeRight multiplier:1.f constant:0.f];
}

#pragma mark - Adding Layouts
- (void)addLayouts:(NSSet *)layouts
{
    for (NSLayoutConstraint *layout in layouts)
    {
        [self addLayout:layout];
    }
}

- (void)addLayout:(NSLayoutConstraint *)layout
{
    assert([layout isKindOfClass:NSLayoutConstraint.class]);
    [self.layouts addObject:layout];
}

#pragma mark - Removing Layouts
- (void)removeLayout:(NSLayoutConstraint *)layout
{
    [self.layouts removeObject:layout];
}

- (void)removeAllLayouts
{
    [self.layouts removeAllObjects];
}

#pragma mark - Checking for Membership
- (void)containsLayout:(NSLayoutConstraint *)layout
{
    [self.layouts containsObject:layout];
}

- (NSSet *)layoutsWithKey:(NSString *)key andValue:(id)value
{
    NSSet *layouts = nil;
    if (self.layouts.count)
    {
        NSError *kvValidationError;
        __autoreleasing id _value = value;
        BOOL valid = [self.layouts.anyObject validateValue:&_value forKey:key error:&kvValidationError];
        if (!valid == !!(kvValidationError) == YES)
        {
            [NSException raise:NGValueInvalidException format:@"%@", kvValidationError.localizedDescription];
        }
        layouts = [self.layouts objectsPassingTest:^BOOL(NSLayoutConstraint *obj, BOOL *stop) {
            assert([obj isKindOfClass:NSLayoutConstraint.class]);
            
            return [[obj valueForKey:key] isEqual:value];
        }];
    }
    
    return layouts;
}

#pragma mark - Counting Layouts
- (NSUInteger)count
{
    return self.layouts.count;
}

#pragma mark - Applying to views
- (void)applyToView:(UIView *)view
{
    [view addConstraints:self.layouts.allObjects];
}

@end
