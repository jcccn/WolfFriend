//
//  Helper.m
//  WolfFriend
//
//  Created by Jiang Chuncheng on 8/21/11.
//  Copyright 2011 SenseForce. All rights reserved.
//

#import "Helper.h"

// Preference
id getPref(NSString *aKey, id aDefaultValue) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *res = [defaults objectForKey:aKey];
    if (res == nil)
        return aDefaultValue;
    else
        return res;
}

void setPref(NSString *aKey, id aValue) {
    if (aKey == nil || aValue == nil)
        return;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:aValue forKey:aKey];
}

int getIntPref(NSString *aKey, int aValue) {
    NSNumber *pref = (NSNumber *)getPref(aKey, nil);
    if (pref) {
        return [pref intValue];
    }
    return aValue;
}

void setIntPref(NSString *aKey, int aValue) {
    if (aKey == nil)
        return;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithInt:aValue] forKey:aKey];
}

void removePref(NSString *aKey) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:aKey];
}

BOOL hasPref(NSString *aKey) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *res = [defaults objectForKey:aKey];
    return res != nil;
}
