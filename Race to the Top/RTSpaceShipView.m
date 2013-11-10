//
//  RTSpaceShipView.m
//  Race to the Top
//
//  Created by Eliot Arntz on 11/6/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTSpaceShipView.h"

@implementation RTSpaceShipView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    /* We create a UIBezierPath object which can be used to setup the geometry of our shape. After we can call stroke or fill to draw the geometrical shape on the screen. We can also set stroke and fill colors */
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    /* Set the bezier path's line width to be 2 points wide. */
    bezierPath.lineWidth = 2.0;
    
    /* We need a start point for the bezier path so we call the method moveToPoint. Notice that we've made the CGPoint's dynamic based on the view's bounds instead of using magic numbers like 280 or 320. */
    [bezierPath moveToPoint:CGPointMake(1/6.0 * self.bounds.size.width, 1/3.0 * self.bounds.size.height)];
    /* addLineToPoint method creates a straight line from the last bezierPath's point to the current point. */
    [bezierPath addLineToPoint:CGPointMake(1/6.0 *self.bounds.size.width, 2/3.0 *self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(5/6.0 * self.bounds.size.width, 2/3.0 *self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(2/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height)];
    [bezierPath addLineToPoint:CGPointMake(1/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height)];
    /* closePath draws a line from the first to the last subpoint */
    [bezierPath closePath];
    /* draws the line defined in the bezierPath object */
    [bezierPath stroke];
    
    /* We can create a CGRect using the method CGRectMake and then add it as a argument for the bezierPathWithRect. This returns a 4 point shape with the specified points in the CGRect. */
    UIBezierPath *cockpitWindowPath = [UIBezierPath bezierPathWithRect:CGRectMake(2/3.0 * self.bounds.size.width, 1/2.0 * self.bounds.size.height, 1/6.0 * self.bounds.size.width, 1/12.0 * self.bounds.size.height)];
    /* Set the fill color to a UIColor so that we will be able to have our shape have a filled color. */
    [[UIColor blueColor] setFill];
    /* Paints the region inside of the UIBezierPath */
    [cockpitWindowPath fill];
}


@end
