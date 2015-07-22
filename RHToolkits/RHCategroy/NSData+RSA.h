//
//  NSData+RSA.h
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/20.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  rsa加密
 *
 *  NSString *rsaPublicKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@"der"];
 *  NSData *rsaPublicKeyData = [NSData dataWithContentsOfFile:rsaPublicKeyPath];
 *
 *  rsa解密
 *
 *  NSString *rsaPrivateKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@"p12"];
 *  NSData *rsaPrivateKeyData = [NSData dataWithContentsOfFile:rsaPrivateKeyPath];
 */
@interface NSData (RSA)

- (NSData *)RSAEncryptWithPublicKey:(NSString *)publicKey;
- (NSData *)RSAEncryptWithPublicKeyData:(NSData *)publicKeyData;

- (NSData *)RSADecryptWithPrivateKey:(NSString *)privateKey password:(NSString *)password;
- (NSData *)RSADecryptWithPrivateKeyData:(NSData *)privateKeyData password:(NSString *)password;

@end
