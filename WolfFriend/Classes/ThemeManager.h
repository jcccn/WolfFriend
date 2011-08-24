//
//  ThemeManager.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeObject : NSObject {
    
}
@end

@interface ThemeManager : NSObject {
    NSString *backgroudColor;
}
@property (nonatomic, retain) NSString *backgroudColor;

+ (ThemeManager *)sharedManager;

- (UIColor *)uiColorWithWebColor:(NSString *)aWebColor;
- (NSString *)webColorWithUIColor:(UIColor *)aUIColor;

@end
