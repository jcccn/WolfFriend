//
//  SiteDIYViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 9/1/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "SiteDIYViewController.h"
#import "Helper.h"

@implementation SiteDIYViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableBackground.png"]];
    
    if ( ! hintLabel) {
        hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
        hintLabel.backgroundColor = [UIColor clearColor];
        hintLabel.text = @"选择或输入内容来源网址";
        [self.view addSubview:hintLabel];
        [hintLabel release];
    }
    if ( ! segmentedControl) {
        segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"默认网址", @"自动获取", @"手动输入", nil]];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
        segmentedControl.frame = CGRectMake(10, 50, 300, 30);
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmentedControl];
        [segmentedControl release];
    }
    
    if ( ! urlFieldPartOne) {
        urlFieldPartOne = [[UITextField alloc] initWithFrame:CGRectMake(10, 90, 90, 30)];
        urlFieldPartOne.borderStyle = UITextBorderStyleRoundedRect;
        urlFieldPartOne.textAlignment = UITextAlignmentRight;
        urlFieldPartOne.keyboardType = UIKeyboardTypeASCIICapable;
        urlFieldPartOne.autocorrectionType = UITextAutocorrectionTypeNo;
        urlFieldPartOne.returnKeyType = UIReturnKeyDone;
        urlFieldPartOne.autocapitalizationType = UITextAutocapitalizationTypeNone;
        urlFieldPartOne.placeholder = @"www";
        urlFieldPartOne.delegate = self;
        [self.view addSubview:urlFieldPartOne];
        [urlFieldPartOne release];
    }
    
    if ( ! dotLableOne) {
        dotLableOne = [[UILabel alloc] initWithFrame:CGRectMake(100, 90, 10, 30)];
        dotLableOne.backgroundColor = [UIColor clearColor];
        dotLableOne.textAlignment = UITextAlignmentCenter;
        dotLableOne.text = @".";
        [self.view addSubview:dotLableOne];
        [dotLableOne release];
    }
    
    if ( ! urlFieldPartTwo) {
        urlFieldPartTwo = [[UITextField alloc] initWithFrame:CGRectMake(110, 90, 100, 30)];
        urlFieldPartTwo.borderStyle = UITextBorderStyleRoundedRect;
        urlFieldPartTwo.textAlignment = UITextAlignmentCenter;
        urlFieldPartTwo.keyboardType = UIKeyboardTypeASCIICapable;
        urlFieldPartTwo.autocorrectionType = UITextAutocorrectionTypeNo;
        urlFieldPartTwo.returnKeyType = UIReturnKeyDone;
        urlFieldPartTwo.autocapitalizationType = UITextAutocapitalizationTypeNone;
        urlFieldPartTwo.placeholder = @"34eee";
        urlFieldPartTwo.delegate = self;
        [self.view addSubview:urlFieldPartTwo];
        [urlFieldPartTwo release];
    }
    
    if ( ! dotLableTwo) {
        dotLableTwo = [[UILabel alloc] initWithFrame:CGRectMake(210, 90, 10, 30)];
        dotLableTwo.backgroundColor = [UIColor clearColor];
        dotLableTwo.textAlignment = UITextAlignmentCenter;
        dotLableTwo.text = @".";
        [self.view addSubview:dotLableTwo];
        [dotLableTwo release];
    }
    
    if ( ! urlFieldPartThree) {
        urlFieldPartThree = [[UITextField alloc] initWithFrame:CGRectMake(220, 90, 90, 30)];
        urlFieldPartThree.borderStyle = UITextBorderStyleRoundedRect;
        urlFieldPartThree.textAlignment = UITextAlignmentLeft;
        urlFieldPartThree.keyboardType = UIKeyboardTypeASCIICapable;
        urlFieldPartThree.autocorrectionType = UITextAutocorrectionTypeNo;
        urlFieldPartThree.returnKeyType = UIReturnKeyDone;
        urlFieldPartThree.autocapitalizationType = UITextAutocapitalizationTypeNone;
        urlFieldPartThree.placeholder = @"com";
        urlFieldPartThree.delegate = self;
        [self.view addSubview:urlFieldPartThree];
        [urlFieldPartThree release];
    }
    
    [segmentedControl setSelectedSegmentIndex:2];
    
    [self resetUI:nil];
}

- (void)resetUI:(id)arg {
    [self willAnimateRotationToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:0];
    if (segmentedControl) {
        segmentedControl.tintColor = [[ThemeManager sharedManager] colorUIFrame];
    }
    [self setBarBackroundColor:[[ThemeManager sharedManager] colorUIFrame]];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    BOOL shouldAuto = NO;
    switch (getIntPref(KeyScreenOrientation, 0)) {
        case 0: {
            shouldAuto = UIInterfaceOrientationIsPortrait(interfaceOrientation);
        }
            break;
            
        case 1: {
            shouldAuto = YES;
        }
            break;
        case 2: {
            shouldAuto = UIInterfaceOrientationIsLandscape(interfaceOrientation);
        }
            break;
        default:
            break;
    }
    return shouldAuto;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        //竖屏
        CGFloat contentHeight = screenRect.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
        segmentedControl.frame = CGRectMake(10, 50, 300, 30);
        urlFieldPartOne.frame = CGRectMake(10, 90, 90, 30);
        dotLableOne.frame = CGRectMake(100, 90, 10, 30);
        urlFieldPartTwo.frame = CGRectMake(110, 90, 100, 30);
        dotLableTwo.frame = CGRectMake(210, 90, 10, 30);
        urlFieldPartThree.frame = CGRectMake(220, 90, 90, 30);
    }
    else {
        //横屏
        CGFloat contentHeight = screenRect.size.width - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
        segmentedControl.frame = CGRectMake(10, 50, 460, 30);
        urlFieldPartOne.frame = CGRectMake(10, 90, 120, 30);
        dotLableOne.frame = CGRectMake(130, 90, 10, 30);
        urlFieldPartTwo.frame = CGRectMake(140, 90, 200, 30);
        dotLableTwo.frame = CGRectMake(340, 90, 10, 30);
        urlFieldPartThree.frame = CGRectMake(350, 90, 120, 30);
    }
    UITabBarController *tabBarController = self.tabBarController;
    UITabBar *tabBar = tabBarController.tabBar;
    UIView *tabBarBackgroundView = [tabBar viewWithTag:TagTabBarBackground];
    if (tabBarBackgroundView) {
        tabBarBackgroundView.frame = tabBar.bounds;
    }
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0: {
            [urlFieldPartOne resignFirstResponder];
            [urlFieldPartTwo resignFirstResponder];
            [urlFieldPartThree resignFirstResponder];
            urlFieldPartOne.userInteractionEnabled = NO;
            urlFieldPartTwo.userInteractionEnabled = NO;
            urlFieldPartThree.userInteractionEnabled = NO;
            urlFieldPartOne.text = @"";
            urlFieldPartTwo.text = @"";
            urlFieldPartThree.text = @"";
        }
            break;
        case 1: {
            [urlFieldPartOne resignFirstResponder];
            [urlFieldPartTwo resignFirstResponder];
            [urlFieldPartThree resignFirstResponder];
            urlFieldPartOne.userInteractionEnabled = NO;
            urlFieldPartTwo.userInteractionEnabled = NO;
            urlFieldPartThree.userInteractionEnabled = NO;
            urlFieldPartOne.text = @"";
            urlFieldPartTwo.text = @"";
            urlFieldPartThree.text = @"";
        }
            break;
        case 2: {
            [urlFieldPartOne resignFirstResponder];
            [urlFieldPartTwo resignFirstResponder];
            [urlFieldPartThree resignFirstResponder];
            urlFieldPartOne.userInteractionEnabled = YES;
            urlFieldPartTwo.userInteractionEnabled = YES;
            urlFieldPartThree.userInteractionEnabled = YES;
            urlFieldPartOne.text = getPref(@"UserUrlPart1", @"");
            urlFieldPartTwo.text = getPref(@"UserUrlPart2", @"");
            urlFieldPartThree.text = getPref(@"UserUrlPart3", @"");
        }
            break;
        default:
            break;
    }
    setIntPref(@"UrlType", sender.selectedSegmentIndex);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self saveUserUrl];
    return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result;
    int length = 0;
    if (textField == urlFieldPartOne) {
        length = 10;
    }
    else if(textField == urlFieldPartTwo) {
        length = 20;
    }
    else if(textField == urlFieldPartThree) {
        length = 5;
    }
    if (textField.text.length >= length && range.length == 0) { 
        result = NO; 
    } 
    else {
        result = YES;
    }
    return result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [urlFieldPartOne resignFirstResponder];
    [urlFieldPartTwo resignFirstResponder];
    [urlFieldPartThree resignFirstResponder];
    [self saveUserUrl];
}

- (void)saveUserUrl {
    setPref(@"UserUrlPart1", urlFieldPartOne.text);
    setPref(@"UserUrlPart2", urlFieldPartTwo.text);
    setPref(@"UserUrlPart3", urlFieldPartThree.text);
}

@end
