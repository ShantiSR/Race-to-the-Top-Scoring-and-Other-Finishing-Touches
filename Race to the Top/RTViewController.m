//
//  RTViewController.m
//  Race to the Top
//
//  Created by Eliot Arntz on 11/6/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "RTViewController.h"
#import "RTPathView.h"
#import "RTMountainPath.h"

/* #defines adds consistency and makes it easy to change values quickly */
#define RTMAP_STARTING_SCORE 15000
#define RTMAP_SCORE_DECREMENT_AMOUNT 100
#define RTTIMER_INTERVAL 0.1
#define RTWALL_PENALTY 500

@interface RTViewController ()

@property (strong, nonatomic) IBOutlet RTPathView *pathView;
@property (strong, nonatomic) NSTimer *timer;

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
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", RTMAP_STARTING_SCORE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Method called when panning is detected on the view. We use a series of if statements to check the GestureRecognizer's state.*/
-(void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    /* Using the method locationInView to determine where in the coordinate system the touch is occuring. */
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    
    /* If the GestureRecognizer just began and the finger location is at the bottom of the screen */
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        /* NSTimer is an object that we will use to call a method repeatedly after a set time interval. We create our NSTimer object with a time interval, method, userinfo set to nil and repeats set to YES. */
        self.timer = [NSTimer scheduledTimerWithTimeInterval:RTTIMER_INTERVAL target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", RTMAP_STARTING_SCORE];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
        /* Use fast enumeration to iterate through the mountainPath's and determine if the user's finger location is on a wall. If it is on a wall penalize the user. */
        for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.pathView.bounds]){
            UIBezierPath *tapTarget = [RTMountainPath tapTargetForPath:path];
            
            if ([tapTarget containsPoint:fingerLocation]){
                [self decrementScoreByAmount:RTWALL_PENALTY];
            }
        }
    }
    /* If the GestureRecognizer ended and the finger location is at the top of the screen */
    else if (panRecognizer.state == UIGestureRecognizerStateEnded && fingerLocation.y <= 165) {
        /* Stop the timer and deallocate the object */
        [self.timer invalidate];
        self.timer = nil;
    }
    else {
        /* If the user has made a mistake use a UIAlertView to let them know */
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure to start at the bottom of the path, hold your finger down and finish at the top of the path!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        /* Stop the timer and deallocate the object */
        [self.timer invalidate];
        self.timer = nil;
    }

}

/* method called when tap detected on the view. */
-(void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    /* Using the method locationInView to determine where in the coordinate system the touch is occuring. */
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    //NSLog(@"tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
}

-(void)timerFired
{
    [self decrementScoreByAmount:RTMAP_SCORE_DECREMENT_AMOUNT];
}

-(void)decrementScoreByAmount:(int)amount
{
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];
    int score = [scoreText intValue];
    score = score - amount;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
}

@end
