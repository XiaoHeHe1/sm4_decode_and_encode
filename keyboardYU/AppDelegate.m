//
//  AppDelegate.m
//  keyboardYU
//
//  Created by yfc on 16/6/27.
//  Copyright © 2016年 yfc. All rights reserved.
//

#import "AppDelegate.h"

#import "sm4test.h"
#import "sms4.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

 {
//  1.将NSString类型的数据转成char[]类型
    NSString *plainIn = @"this is plain text";
    NSData *plainInData =[plainIn dataUsingEncoding:NSUTF8StringEncoding];
    int dataLength =plainInData.length;   ;
    unsigned char plainInChar[dataLength];
//  memcpy函数：将plainInData数据dataLength长度的部分复制到plainInChar里面
    memcpy(plainInChar, plainInData.bytes, dataLength);

//  说明：1.dataLength这个长度很重要，刚开始时候用过strlen和sizeof,plainIn.length发现英文情况下没问题，中文的话数据会有缺失
//       2.进制转换，要将平时的10进制数据转成16进制，在这里使用NSData它默认就是以16进制保存的，这里省略进制转换的步骤
}
    
    
//  2.对明文数据进行填充来保证位数是16的倍数,为了少声明一个变量在这里把填充和第1步放在一起
    NSString *plainIn = @"this is plain text";
    NSData *plainInData =[plainIn dataUsingEncoding:NSUTF8StringEncoding];
    int plainInDataLength =plainInData.length;   ;
//  p是需要填充的数据也是填充的位数
    int p = 16 - plainInDataLength % 16;
    unsigned char plainInChar[plainInDataLength + p];
    memcpy(plainInChar, plainInData.bytes, plainInDataLength);
//  进行数据填充
    for (int i = 0; i < p; i++)
    {
        plainInChar[plainInDataLength + i] =  p;
    }
    
//3.验证一下填充后的char[]是不是最开始的明文数据
    NSLog(@"plainInData=%@",plainInData);
    NSData *data = [[NSData alloc]initWithBytes:plainInChar length:sizeof(plainInChar)-p];
    NSLog(@"data=%@",data);
    NSLog(@"填充后的char[]转成NSString=%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    
//4.对plainInChar加密，由于源代码中加解密是放在一起的，现在在sm4test.c中新添加两个方法把加密和解密分开,由于计算length总出问题，所以直接把length作为参数传进去
   
    //5.调用刚才添加的方法加密
    //定义输出密文的变量
    unsigned char cipherOutChar[plainInDataLength + p];
    testEncodejiami(plainInDataLength + p, plainInChar, cipherOutChar);
    //对加密的数据输出
    NSData *cipherTextData =  [[NSData alloc]initWithBytes:cipherOutChar length:sizeof(cipherOutChar)];
    NSLog(@"密文NSData=%@",cipherTextData);
    NSLog(@"密文转成NSString=%@",[[NSString alloc]initWithData:cipherTextData encoding:NSUTF8StringEncoding]);

    
    //6将cipherTextData作为输入，调用第4步的解密方法，进行解密
    //将data拷贝到字符数组中
    unsigned char cipherTextChar[cipherTextData.length];
    memcpy(cipherTextChar, cipherTextData.bytes, cipherTextData.length);
    //调用解密方法，输出是明文plainOutChar
    unsigned char plainOutChar[cipherTextData.length];
    testDecodejiemi(cipherTextData.length, cipherTextChar, plainOutChar);
    //由于明文是填充过的，解密时候要去填充，去填充要在解密后才可以，在解密前是去不了的
    int p2 = plainOutChar[sizeof(plainOutChar) - 1];//p2是填充的数据，也是填充的长度
    int outLength = cipherTextData.length-p2;//明文的长度
    //去掉填充得到明文
    unsigned char plainOutWithoutPadding[outLength];
    memcpy(plainOutWithoutPadding, plainOutChar, outLength);
    //明文转成NSData 再转成NSString打印
    NSData *outData = [[NSData alloc]initWithBytes:plainOutWithoutPadding length:sizeof(plainOutWithoutPadding)];
    
    NSString *str =[[NSString alloc]initWithData:outData encoding:NSUTF8StringEncoding];
    NSLog(@"解密得到的明文是:%@",str);
    
    
    return YES;
}
@end
