//
//  ViewController.h
//  Spinner Test
//
//  Created by Asad Quraishi on 2012-08-23.
//  Copyright (c) 2012 Asad Quraishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic, weak) IBOutlet UILabel *redLabel;
@property (nonatomic, weak) IBOutlet UILabel *blueLabel;
@property (nonatomic, weak) IBOutlet UILabel *greenLabel;
@property (nonatomic, weak) IBOutlet UILabel *alphaLabel;
@property (nonatomic, weak) IBOutlet UITextField *scaleX;
@property (nonatomic, weak) IBOutlet UITextField *scaleY;
@property (nonatomic, weak) IBOutlet UISwitch *whiteLargeSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *whiteSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *graySwitch;


- (IBAction)setSpinnerType:(UISwitch *)sender;
- (IBAction)setColour:(UISlider *)sender;

@end
