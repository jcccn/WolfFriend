//
//  ThemeDIYViewController.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/25/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "ThemeDIYViewController.h"
#import "ThemeManager.h"
#import "HTMLTool.h"

#define TagAlertViewSave    1500
#define TagAlertViewCacel   1501


@implementation ThemeDIYViewController

@synthesize frameColor, textBackgroundColor, textFontColor;

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
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.title = @"DIY主题";
    self.view.backgroundColor = self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TableBackground.png"]];

    if ( ! scrollView) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:scrollView];
        
        CGFloat commonWidth = self.view.bounds.size.width - 20;
        
        self.textBackgroundColor = [[ThemeManager sharedManager] colorReadBackground];
        self.textFontColor = [[ThemeManager sharedManager] colorReadText];
        self.frameColor = [[ThemeManager sharedManager] colorUIFrame];
        textFontSize = [[ThemeManager sharedManager] fontSizeRead];
        
        colorHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, commonWidth, 30)];
        colorHintLabel.backgroundColor = [UIColor clearColor];
        colorHintLabel.text = @"颜色设置";
        colorHintLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:colorHintLabel];
        
        colorTypeSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"界面边框", @"阅读文字", @"阅读背景", nil]];
        colorTypeSegmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        colorTypeSegmentedControl.frame = CGRectMake(10, 50, commonWidth, 30);
        colorTypeSegmentedControl.tintColor = [[ThemeManager sharedManager] colorUIFrame];
        colorTypeSegmentedControl.selectedSegmentIndex = 0;
        [colorTypeSegmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        colorTypeSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:colorTypeSegmentedControl];
        
        rColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 30, 30)];
        rColorLabel.backgroundColor = [UIColor clearColor];
        rColorLabel.textAlignment = NSTextAlignmentCenter;
        rColorLabel.adjustsFontSizeToFitWidth = YES;
        rColorLabel.text = @"R";
        rColorLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:rColorLabel];
        
        gColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 30, 30)];
        gColorLabel.backgroundColor = [UIColor clearColor];
        gColorLabel.textAlignment = NSTextAlignmentCenter;
        gColorLabel.text = @"G";
        gColorLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:gColorLabel];
        
        bColorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 30, 30)];
        bColorLabel.backgroundColor = [UIColor clearColor];
        bColorLabel.textAlignment = NSTextAlignmentCenter;
        bColorLabel.text = @"B";
        bColorLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:bColorLabel];
        
        rSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, rColorLabel.center.y - 15, commonWidth - 30, 30)];
        rSlider.minimumValue = 0;
        rSlider.maximumValue = 1;
        rSlider.value = 0;
        [rSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        rSlider.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:rSlider];
        
        gSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, gColorLabel.center.y - 15, commonWidth - 30, 30)];
        gSlider.minimumValue = 0;
        gSlider.maximumValue = 1;
        gSlider.value = 0;
        [gSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        gSlider.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:gSlider];
        
        bSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, bColorLabel.center.y - 15, commonWidth - 30, 30)];
        bSlider.minimumValue = 0;
        bSlider.maximumValue = 1;
        bSlider.value = 0;
        [bSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        bSlider.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:bSlider];
        
        fontSizeHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 190, commonWidth, 30)];
        fontSizeHintLabel.backgroundColor = [UIColor clearColor];
        fontSizeHintLabel.text = @"字体大小";
        fontSizeHintLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:fontSizeHintLabel];
        
        fontSizeSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 210, commonWidth, 30)];
        fontSizeSlider.minimumValue = 10;
        fontSizeSlider.maximumValue = 30;
        fontSizeSlider.value = [[ThemeManager sharedManager] fontSizeRead];
        [fontSizeSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        fontSizeSlider.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:fontSizeSlider];
        
        textExampleWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 240, commonWidth, 50)];
        textExampleWebView.scrollView.scrollEnabled = NO;
        textExampleWebView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        [scrollView addSubview:textExampleWebView];
        
        saveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        saveButton.frame = CGRectMake(50, 310, 80, 40);
        [saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [saveButton addTarget:self action:@selector(saveClicked:) forControlEvents:UIControlEventTouchUpInside];
        saveButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [scrollView addSubview:saveButton];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelButton.frame = CGRectMake(commonWidth - 180, 310, 80, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [scrollView addSubview:cancelButton];
        
    }
    
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, CGRectGetMaxY(cancelButton.frame) + 10);
    
    [self changeTempColor:[[ThemeManager sharedManager] colorUIFrame] forTypeIndex:0];
    [self changeTempColor:[[ThemeManager sharedManager] colorReadText] forTypeIndex:1];
    [self changeTempColor:[[ThemeManager sharedManager] colorReadBackground] forTypeIndex:2];
    [self changeTempFontSize:[[ThemeManager sharedManager] fontSizeRead]];
    [self performSelector:@selector(segmentedControlValueChanged:) withObject:colorTypeSegmentedControl];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self resetUI:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)resetUI:(id)arg {
    [self willAnimateRotationToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:0];
    [self changeTempColor:self.frameColor forTypeIndex:0];

}

- (void)segmentedControlValueChanged:(UISegmentedControl *)sender {
    UIColor *theColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    switch (sender.selectedSegmentIndex) {
        case 0: {
            
            theColor = self.frameColor;
        }
            break;
            
        case 1: {
            theColor = self.textFontColor;
        }
            break;
            
        case 2: {
            theColor = self.textBackgroundColor;
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
        [self changeTempColor:[UIColor colorWithRed:rSlider.value green:gSlider.value blue:bSlider.value alpha:1] 
                 forTypeIndex:colorTypeSegmentedControl.selectedSegmentIndex];
    }
    else if (sender == fontSizeSlider) {
        [self changeTempFontSize:fontSizeSlider.value];
    }
}

- (void)changeTempReadBackgroundColor:(UIColor *)aBackgroundColor fontColor:(UIColor *)aFontColor fontSize:(CGFloat)aFontSize {
    NSString *htmlString = [HTMLTool formatHTML:@"这是示例文字" 
                                  withFontColor:[[ThemeManager sharedManager] webColorWithUIColor:aFontColor]
                                backgroundColor:[[ThemeManager sharedManager] webColorWithUIColor:aBackgroundColor]
                                       fontSize:aFontSize];
    [textExampleWebView loadHTMLString:htmlString baseURL:nil];
}

- (void)changeTempRead {
    [self changeTempReadBackgroundColor:self.textBackgroundColor fontColor:self.textFontColor fontSize:textFontSize];
}

- (void)changeTempColor:(UIColor *)aColor forTypeIndex:(NSInteger)anIndex {
    switch (anIndex) {
            //界面边框
        case 0: {
            self.frameColor = aColor;
            self.navigationController.navigationBar.tintColor = aColor;
            [self setBarBackroundColor:aColor];
            colorTypeSegmentedControl.tintColor = aColor;
        }
            break;
            //阅读文字
        case 1: {
            self.textFontColor = aColor;
            [self changeTempRead];
        }
            break;
            //阅读背景
        case 2: {
            self.textBackgroundColor = aColor;
            [self changeTempRead];
        }
            break;
            
        default:
            break;
    }
}

- (void)changeTempFontSize:(CGFloat)floatFontSize {
    textFontSize = floatFontSize;
    [self changeTempRead];
}

- (void)saveClicked:(id)sender {
    UIAlertView *alertViewSave = [[UIAlertView alloc] initWithTitle:@"确定保存？" 
                                                            message:@"保存将会覆盖当前使用的主题"
                                                           delegate:self 
                                                  cancelButtonTitle:@"继续编辑"
                                                  otherButtonTitles:@"保存", nil];
    alertViewSave.tag = TagAlertViewSave;
    [alertViewSave show];
}

- (void)cancelClicked:(id)sender {
    UIAlertView *alertViewCancel = [[UIAlertView alloc] initWithTitle:@"确定放弃？" 
                                                            message:@"放弃将会丢失当前编辑的主题"
                                                           delegate:self 
                                                  cancelButtonTitle:@"放弃"
                                                  otherButtonTitles:@"继续编辑", nil];
    alertViewCancel.tag = TagAlertViewCacel;
    [alertViewCancel show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (alertView.tag) {
        case TagAlertViewSave: {
            switch (buttonIndex) {
                case 1: {
                    //保存
                    [self saveTheme];
                    [self.navigationController popViewControllerAnimated:YES];
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
    [[ThemeManager sharedManager] setColorUIFrame:self.frameColor];
    [[ThemeManager sharedManager] setColorReadText:self.textFontColor];
    [[ThemeManager sharedManager] setColorReadBackground:self.textBackgroundColor];
    [[ThemeManager sharedManager] setFontSizeRead:fontSizeSlider.value];
    [[ThemeManager sharedManager] saveTheme];
}

- (void)cancel {
    
}

@end
