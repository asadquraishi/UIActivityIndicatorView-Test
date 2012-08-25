//
//  ViewController.m
//  Spinner Test
//
//  Created by Asad Quraishi on 2012-08-23.
//  Copyright (c) 2012 Asad Quraishi. All rights reserved.
//

#import "ViewController.h"

#define kUIActivityIndicatorViewStyleWhiteLarge 1
#define kUIActivityIndicatorViewStyleWhite      2
#define kUIActivityIndicatorViewStyleGray       3
#define kRedSlider      1
#define kBlueSlider     2
#define kGreenSlider    3
#define kAlphaSlider    4

// create contstants representing each tag value for the switches

@interface ViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic) CGFloat redColor;
@property (nonatomic) CGFloat blueColor;
@property (nonatomic) CGFloat greenColor;
@property (nonatomic) CGFloat alphaColor;
@end

@implementation ViewController
@synthesize label = _label;
@synthesize scaleX = _scaleX;
@synthesize scaleY = _scaleY;
@synthesize whiteLargeSwitch = _whiteLargeSwitch;
@synthesize whiteSwitch = _whiteSwitch;
@synthesize graySwitch = _graySwitch;
@synthesize spinner = _spinner;
@synthesize redLabel = _redLabel;
@synthesize blueLabel = _blueLabel;
@synthesize greenLabel = _greenLabel;
@synthesize alphaLabel = _alphaLabel;
@synthesize redColor;
@synthesize blueColor;
@synthesize greenColor;
@synthesize alphaColor;

- (IBAction)process
{
    self.spinner.center = self.view.center;
    // make center using cgpointfromstring - first create a string with format from scalex and y
    NSString *spinnerCenterAsString = [NSString stringWithFormat:@"{%@,%@}", self.scaleX.text, self.scaleY.text];
    CGPoint spinnerCenter = CGPointFromString(spinnerCenterAsString);
    self.spinner.transform = CGAffineTransformMakeScale(spinnerCenter.x, spinnerCenter.x);
    // spinner.frame = CGRectMake(self.view.center.x, self.view.center.y, 60, 60);
    self.spinner.hidesWhenStopped = YES;
    [self.view addSubview:self.spinner];
    [self.spinner startAnimating];
    
    // how we stop refresh from freezing the main UI thread
    dispatch_queue_t downloadQueue = dispatch_queue_create("downloader", NULL);
    dispatch_async(downloadQueue, ^{
        
        // do our long running process here
        [NSThread sleepForTimeInterval:10];
        
        // do any UI stuff on the main UI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = @"After!";
            [self.spinner stopAnimating];
            // NSLog(@"scaleX = %@", self.scaleX.text);
            // NSLog(@"scaleY = %@", self.scaleY.text);

        });
        
    });
    dispatch_release(downloadQueue);
}

- (IBAction)setSpinnerType:(UISwitch *)sender
{
    // switch based on tag value
    // turn other two switches off
    switch (sender.tag) {
        case kUIActivityIndicatorViewStyleWhiteLarge:
            self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [sender setOn:YES animated:YES];
            [self.whiteSwitch setOn:NO animated:YES];
            [self.graySwitch setOn:NO animated:YES];
            break;
        case kUIActivityIndicatorViewStyleWhite:
            self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            [self.whiteLargeSwitch setOn:NO animated:YES];
            [sender setOn:YES animated:YES];
            [self.graySwitch setOn:NO animated:YES];
            break;
        case kUIActivityIndicatorViewStyleGray:
            self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [self.whiteLargeSwitch setOn:NO animated:YES];
            [self.whiteSwitch setOn:NO animated:YES];
            [sender setOn:YES animated:YES];
            break;
        default:
            break;
    }
}

- (IBAction)setColour:(UISlider *)sender
{
    // add #define kRedSwitch... or something else
    // investigate how to change the color realtime
    // create a UIcolor object with colrWithRed:green:blue:alpha or initWithRed...
    //
    // self.view.backgroundColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>];
    
    switch (sender.tag) {
        case kRedSlider:
            self.redColor = sender.value;
            self.redLabel.text = [NSString stringWithFormat:@"%.2f", self.redColor];
            // self.view.backgroundColor = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:self.alphaColor];
            break;
        case kBlueSlider:
            self.blueColor = sender.value;
            self.blueLabel.text = [NSString stringWithFormat:@"%.2f", self.blueColor];
            // self.view.backgroundColor = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:self.alphaColor];
            break;
        case kGreenSlider:
            self.greenColor = sender.value;
            self.greenLabel.text = [NSString stringWithFormat:@"%.2f", self.greenColor];
            break;
        case kAlphaSlider:
            self.alphaColor = sender.value;
            self.alphaLabel.text = [NSString stringWithFormat:@"%.2f", self.alphaColor];
            break;
        default:
            break;
    }
    self.view.backgroundColor = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:self.alphaColor];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scaleX.text = @"1.0";
    self.scaleY.text = @"1.0";
    self.label.text = @"Before";
    self.whiteLargeSwitch.on = YES;
    self.whiteSwitch.on = NO;
    self.graySwitch.on = NO;
    self.redColor = 0.500;
    self.blueColor = 0.500;
    self.greenColor = 0.500;
    self.alphaColor = 1.000;
    self.view.backgroundColor = [UIColor colorWithRed:self.redColor green:self.greenColor blue:self.blueColor alpha:self.alphaColor];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
