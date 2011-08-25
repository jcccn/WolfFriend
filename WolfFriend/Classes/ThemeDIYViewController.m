//
//  ThemeDIYViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ThemeDIYViewController.h"
#import "ThemeManager.h"

#define TagAlertViewSave    1500
#define TagAlertViewCacel   1501


@implementation ThemeDIYViewController

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
    self.title = @"DIY主题";
    self.view.backgroundColor = [[ThemeManager sharedManager] uiColorWithWebColor:[[ThemeManager sharedManager] backgroudColor]];
     
    if ( ! scrollView) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:scrollView];
        
        colorHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        colorHintLabel.backgroundColor = [UIColor clearColor];
        colorHintLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        colorHintLabel.text = @"颜色设置";
        [scrollView addSubview:colorHintLabel];
        [colorHintLabel release];
        
        colorTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"界面文字", @"界面背景", @"界面边框", @"阅读文字", @"阅读背景", nil]];
        colorTypeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        colorTypeSegmentedControl.frame = CGRectMake(10, 50, 300, 20);
        colorTypeSegmentedControl.tintColor = [UIColor colorWithRed:0 green:0 blue:100 alpha:0.5];
        colorTypeSegmentedControl.selectedSegmentIndex = 0;
        [colorTypeSegmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:colorTypeSegmentedControl];
        
        rColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80, 30, 30)];
        rColorLabel.backgroundColor = [UIColor clearColor];
        rColorLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        rColorLabel.textAlignment = UITextAlignmentCenter;
        rColorLabel.adjustsFontSizeToFitWidth = YES;
        rColorLabel.text = @"R";
        [scrollView addSubview:rColorLabel];
        [rColorLabel release];
        
        gColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110, 30, 30)];
        gColorLabel.backgroundColor = [UIColor clearColor];
        gColorLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        gColorLabel.textAlignment = UITextAlignmentCenter;
        gColorLabel.text = @"G";
        [scrollView addSubview:gColorLabel];
        [gColorLabel release];
        
        bColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 30, 30)];
        bColorLabel.backgroundColor = [UIColor clearColor];
        bColorLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        bColorLabel.textAlignment = UITextAlignmentCenter;
        bColorLabel.text = @"B";
        [scrollView addSubview:bColorLabel];
        [bColorLabel release];
        
        rSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, rColorLabel.center.y - 15, 270, 30)];
        rSlider.minimumValue = 0;
        rSlider.maximumValue = 1;
        rSlider.value = 0;
        [rSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:rSlider];
        [rSlider release];
        
        gSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, gColorLabel.center.y - 15, 270, 30)];
        gSlider.minimumValue = 0;
        gSlider.maximumValue = 1;
        gSlider.value = 0;
        [gSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:gSlider];
        [gSlider release];
        
        bSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, bColorLabel.center.y - 15, 270, 30)];
        bSlider.minimumValue = 0;
        bSlider.maximumValue = 1;
        bSlider.value = 0;
        [bSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:bSlider];
        [bSlider release];
        
        lightHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 180, 80, 30)];
        lightHintLabel.backgroundColor = [UIColor clearColor];
        lightHintLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        lightHintLabel.text = @"亮度调节";
        [scrollView addSubview:lightHintLabel];
        [lightHintLabel release];

        lightSlider = [[UISlider alloc] initWithFrame:CGRectMake(90, lightHintLabel.center.y - 15, 220, 30)];
        lightSlider.minimumValue = 20;
        lightSlider.maximumValue = 100;
        lightSlider.value = 100;
        [lightSlider  addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:lightSlider];
        [lightSlider release];
        
        fontSizeHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 80, 30)];
        fontSizeHintLabel.backgroundColor = [UIColor clearColor];
        fontSizeHintLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        fontSizeHintLabel.text = @"字体大小";
        [scrollView addSubview:fontSizeHintLabel];
        [fontSizeHintLabel release];
        
        fontSizeSlider = [[UISlider alloc] initWithFrame:CGRectMake(90, fontSizeHintLabel.center.y - 15, 220, 30)];
        fontSizeSlider.minimumValue = 12;
        fontSizeSlider.maximumValue = 30;
        fontSizeSlider.value = 18;
        [fontSizeSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        [scrollView addSubview:fontSizeSlider];
        [fontSizeSlider release];
        
        textExampleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, 300, 50)];
        textExampleLabel.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        textExampleLabel.textColor = [UIColor blueColor];
        textExampleLabel.font = [UIFont systemFontOfSize:18];
        textExampleLabel.text = @"这是示例文字";
        [scrollView addSubview:textExampleLabel];
        [textExampleLabel release];
        
        saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        saveButton.frame = CGRectMake(50, 320, 80, 30);
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:saveButton];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(190, 320, 80, 30);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:cancelButton];
        
        [scrollView release];
    }
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat contentHeight = screenRect.size.height - self.tabBarController.tabBar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
    scrollView.frame = CGRectMake(0, 0, screenRect.size.width, contentHeight);
    scrollView.contentSize = CGSizeMake(screenRect.size.width, 360);  //a test value
    
    
}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    UIColor *theColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    switch (sender.selectedSegmentIndex) {
        case 0: {
            theColor = colorHintLabel.textColor;
        }
            break;
        
        case 1: {
            theColor = self.view.backgroundColor;
        }
            break;
            
        case 2: {
            theColor = self.navigationController.navigationBar.tintColor;
        }
            break;
            
        case 3: {
            theColor = textExampleLabel.textColor;
        }
            break;
            
        case 4: {
            theColor = textExampleLabel.backgroundColor;
        }
            break;
        default:
            break;
    }
    const float* colors = CGColorGetComponents(theColor.CGColor);
    if (!colors) {
        return;
    }
    [rSlider setValue:colors[0] animated:YES];
    [gSlider setValue:colors[1] animated:YES];
    [bSlider setValue:colors[2] animated:YES];
}

- (void)sliderValueChanged:(id)sender {
    if ((sender == rSlider) || (sender == gSlider) || (sender == bSlider)) {
        [self changeTempColor:[UIColor colorWithRed:rSlider.value green:gSlider.value blue:bSlider.value alpha:1] forTypeIndex:colorTypeSegmentedControl.selectedSegmentIndex];
    }
    else if (sender == lightSlider) {
        [self changetempLight:lightSlider.value];
    }
    else if (sender == fontSizeSlider) {
        [self changeTempFontSize:fontSizeSlider.value];
    }
}

- (void)changeTempColor:(UIColor *)aColor forTypeIndex:(NSInteger)anIndex {
    switch (anIndex) {
            //界面文字
        case 0: {
            colorHintLabel.textColor = aColor;
            rColorLabel.textColor = gColorLabel.textColor = bColorLabel.textColor = aColor;
            lightHintLabel.textColor = aColor;
            fontSizeHintLabel.textColor = aColor;
        }
            break;
            //界面背景
        case 1: {
            self.view.backgroundColor = aColor;
        }
            break;
            //界面边框
        case 2: {
            self.navigationController.navigationBar.tintColor = aColor;
            [self setTabBarBackroundColor:aColor];
            colorTypeSegmentedControl.tintColor = aColor;
        }
            break;
            //阅读文字
        case 3: {
            textExampleLabel.textColor = aColor;
        }
            break;
            //阅读背景
        case 4: {
            textExampleLabel.backgroundColor = aColor;
        }
            break;
            
        default:
            break;
    }
}

- (void)changetempLight:(CGFloat)floatLight {
    [self setLightPercent:(NSInteger)floatLight];
    self.navigationController.navigationBar.alpha = floatLight/100;
//    self.tabBarController.tabBar.alpha = 0;
}

- (void)changeTempFontSize:(CGFloat)floatFontSize {
    textExampleLabel.font = [UIFont systemFontOfSize:floatFontSize];
}

- (void)saveClicked:(id)sender {
    UIAlertView *alertViewSave = [[UIAlertView alloc] initWithTitle:@"确定保存？" 
                                                            message:@"保存将会覆盖当前使用的主题"
                                                           delegate:self 
                                                  cancelButtonTitle:@"继续编辑"
                                                  otherButtonTitles:@"保存", nil];
    alertViewSave.tag = TagAlertViewSave;
    [alertViewSave show];
    [alertViewSave release];
}

- (void)cancelClicked:(id)sender {
    UIAlertView *alertViewCancel = [[UIAlertView alloc] initWithTitle:@"确定放弃？" 
                                                            message:@"放弃将会丢失当前编辑的主题"
                                                           delegate:self 
                                                  cancelButtonTitle:@"放弃"
                                                  otherButtonTitles:@"继续编辑", nil];
    alertViewCancel.tag = TagAlertViewCacel;
    [alertViewCancel show];
    [alertViewCancel release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case TagAlertViewSave: {
            switch (buttonIndex) {
                case 1: {
                    //保存
                    [self saveTheme];
                    [self.navigationController popViewControllerAnimated:YES];
//                    [self dismissModalViewControllerAnimated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case TagAlertViewCacel: {
            switch (buttonIndex) {
                case 0: {
                    //放弃并且返回
                    [self cancel];
                    [self.navigationController popViewControllerAnimated:YES];
//                    [self dismissModalViewControllerAnimated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)saveTheme {
    
}

- (void)cancel {
    
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
