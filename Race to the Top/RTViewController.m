//
//  RTViewController.m
//  Race to the Top
//
//  Created by Eliot Arntz on 11/6/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTViewController.h"
#import "RTPathView.h"

@interface RTViewController ()

@property (strong, nonatomic) IBOutlet RTPathView *pathView;

@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /* Create a UITapGestureRecognizer. Make sure to initialize it with a target of self to alert the RTViewController object that a tap has occured. Supply the action with a method by using the @selector keyword and the method name. Remember to add a colon after the method name! */
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    /* Set the number of taps required to call the method to be 2 */
    tapRecognizer.numberOfTapsRequired = 2;
    /* Add the tag gesture recognizer to the pathView. */
    [self.pathView addGestureRecognizer:tapRecognizer];
    
    /* Create a UIPanGestureRecognizer which calls the method panDetected when the user drags their finger on the screen */
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    [self.pathView addGestureRecognizer:panRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Method called when panning is detected on the view. */
-(void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    /* Using the method locationInView to determine where in the coordinate system the touch is occuring. */
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    
    NSLog(@"I'm at (%f %f)", fingerLocation.x, fingerLocation.y);
}

/* method called when tap detected on the view. */
-(void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    /* Using the method locationInView to determine where in the coordinate system the touch is occuring. */
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    NSLog(@"tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
}

@end
