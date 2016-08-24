/*
 *  pinyin.h
 *  Chinese Pinyin First Letter
 *
 *  Created by stkcctv on 16/8/24.
 *  Copyright © 2016年 stkcctv. All rights reserved.
 *
 */

/*
 * // Example
 *
 * #import "pinyin.h"
 *
 * NSString *hanyu = @"中国共产党万岁！";
 * for (int i = 0; i < [hanyu length]; i++)
 * {
 *     printf("%c", pinyinFirstLetter([hanyu characterAtIndex:i]));
 * }
 *
 */

char pinyinFirstLetter(unsigned short hanzi);