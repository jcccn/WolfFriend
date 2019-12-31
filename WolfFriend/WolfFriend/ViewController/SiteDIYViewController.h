//
//  SiteDIYViewController.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 9/1/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+Extension.h"

@interface SiteDIYViewController : UIViewController <UITextFieldDelegate> {
    UILabel *hintLabel;
    UISegmentedControl *segmentedControl;
    UITextField *urlFieldPartOne;
    UITextField *urlFieldPartTwo;
    UITextField *urlFieldPartThree;
    UILabel *dotLableOne;
    UILabel *dotLableTwo;
}

- (void)resetUI:(id)arg;

- (void)saveUserUrl;

@end
