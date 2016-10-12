//
//  Utilities.m
//  HaierSmart
//
//  Created by Vols on 16/3/7.
//  Copyright © 2016年 HaierSmart. All rights reserved.
//

#import "XCUtilities.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>

#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

#define kUSER_ID            @"USERID"
#define kUSER_IMAGE         @"USER_IMAGE"
#define kUSER_NICK_NAME     @"USER_NICK_NAME"
#define kUSER_SEX           @"USER_SEX"
#define kUSER_MOBILE        @"USERMOBILE"
#define kUSER_AGE_GROUP     @"USER_AGE_GROUP"
#define kUSER_PREFERENCE    @"USER_PREFERENCE"

@implementation XCUtilities

+ (NSString *)emojiWithCode:(int)code {
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}

+ (void) showLoginVC:(UIViewController *)vc {
    
}

+ (NSString *)dictionaryToJsonStr:(NSDictionary *)dic {
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *) MD5WithString:(NSString *)string {
    
    const char* original_str = [string UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, strlen(original_str), digist);
    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
    for(int  i =0; i<CC_MD5_DIGEST_LENGTH;i++){
        [outPutStr appendFormat:@"%02x", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString];
}



+ (BOOL) hasLogin; {
    
    if (nil != [[NSUserDefaults standardUserDefaults] stringForKey:kUSER_ID]) {
        return true;
    } else {
        return false;
    }
}



+ (void) removeUserInfo; {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"actived"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSER_IMAGE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSER_NICK_NAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSER_SEX];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSER_MOBILE];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUSER_AGE_GROUP];
}



+ (void)versionCheck
{
    NSString *nowVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    [[XCHttpRequest shareInstance].url(@"http://itunes.apple.com/lookup?id=1118813638") requestTaskWithSuccess:^(id result) {
        if ([[result allKeys] containsObject:@"results"]) {
           NSArray *array = [result objectForKey:@"results"];
            if (array.count > 0) {
                NSDictionary *dict = array[0];
                if ([[dict allKeys] containsObject:@"version"]) {
                    NSString *newVersion = [dict objectForKey:@"version"];
                    NSLog(@"--------nowVersion:%@    -----newVersion:%@", nowVersion, newVersion);
                    if ([self hasNewVersionWithNowVersion:nowVersion newVersion:newVersion]) {
                        NSString *releaseNotes = @"";
                        if ([[dict allKeys] containsObject:@"releaseNotes"]) {
                            releaseNotes = [dict objectForKey:@"releaseNotes"];
                        }
                        if ([releaseNotes rangeOfString:@"闪退"].location != NSNotFound) {
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"有新版本啦" message:@"更炫更快更好用，快去更新吧！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            av.tag = 0;
                            [av show];
                        }else{
                            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"有新版本啦" message:@"更炫更快更好用，快去更新吧！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                            av.tag = 1;
                            [av show];
                        }
                    }
                }
            }
        }
    } fail:^(NSError *error) {
        ;
    }];
}

+ (BOOL)hasNewVersionWithNowVersion:(NSString *)nowVersion newVersion:(NSString *)newVersion
{
    NSArray *nowArray = [nowVersion componentsSeparatedByString:@"."];
    NSArray *newArray = [newVersion componentsSeparatedByString:@"."];
    if (nowArray.count != 3 || newArray.count != 3) {
        return NO;
    }
    
    if ([nowArray[0] integerValue] < [newArray[0] integerValue]) {
        return YES;
    }else if ([nowArray[0] isEqualToString:newArray[0]]){
        if ([nowArray[1] integerValue] < [newArray[1] integerValue]) {
            return YES;
        }else if ([nowArray[1] isEqualToString:newArray[1]]){
            if ([nowArray[2] integerValue] < [newArray[2] integerValue]) {
                return YES;
            }
        }
    }
    
    return NO;
}









@end
