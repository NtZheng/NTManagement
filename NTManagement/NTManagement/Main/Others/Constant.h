//
//  Constant.h
//  NTManagement
//
//  Created by Nineteen on 7/30/16.
//  Copyright © 2016 nineteen. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

// 颜色
#define NTColor [UIColor colorWithRed:97/255.0 green:147/255.0 blue:224/255.0 alpha:1.0]
#define NTSetColor(R,G,B) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:1.0]

// 共有量
#define NTScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define NTScreenHeight ([UIScreen mainScreen].bounds.size.height)

// URL
#define NTUnreadedFileURL(mobile) [NSString stringWithFormat:@"http://mountainfile.applinzi.com/returnfile.php?mobile=%@&request=0",(mobile)]
#define NTFlowURL(fileName) [NSString stringWithFormat:@"http://mountainfile.applinzi.com/returnfileinfo.php?filename=%@&request=flow",(fileName)]


#endif /* Constant_h */
