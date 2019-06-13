//
//  Settings.m
//  AotteriTunes
//
//  Created by user on 2019/6/10.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "Settings.h"

//@interface Settings ()
//
//@end

@implementation Settings

+(Settings *)sharedSettings {
    
    static Settings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedSettings = [[self alloc] init];
    });
    
    return sharedSettings;
}

- (void)bgcolorChanged:(UIColor *)color {
     _themeColor = color ;
}

@end
