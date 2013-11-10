//
//  RTPathView.m
//  Race to the Top
//
//  Created by Eliot Arntz on 11/6/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTPathView.h"
#import "RTMountainPath.h"

@implementation RTPathView

/* In case we initialize a RTPathView in the future in code we add the setup method. However, for this application we will not be creating a RTPathView in code. */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

/* We override the method initWithCoder since this view will be initialized from the storyboard. Call the setup method to set the background color. */
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self setup];
    }
    return self;
}

/* Helper method which sets the background color to be clear. */
-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    /* Use fast enumeration to iterate through the NSArray returned from the class method mountainPathsForRect. The class method accepts 1 parameter a CGRect so we pass in the current view's bounds. For each UIBezierPath in the array we set the stroke color to black and then call the method stroke to present the line on the screen. */
    for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.bounds])
    {
        [[UIColor blackColor] setStroke];
        [path stroke];
    }
}


@end
