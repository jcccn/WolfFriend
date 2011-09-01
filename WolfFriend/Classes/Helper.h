//
//  Helper.h
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import <Foundation/Foundation.h>

// Preference
id getPref(NSString *aKey, id aDefaultValue);
void setPref(NSString *aKey, id aValue);
int getIntPref(NSString *aKey, int aValue);
void setIntPref(NSString *aKey, int aValue);
void removePref(NSString *aKey);
BOOL hasPref(NSString *aKey);
