//
//  NSData+RSA.m
//  RHToolkitsDemo
//
//  Created by zhuruhong on 15/7/20.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "NSData+RSA.h"
#import "Base64.h"

@implementation NSData (RSA)

- (NSData *)RSAEncryptWithPublicKey:(NSString *)publicKey
{
    NSData *publicKeyData = [NSData dataWithBase64EncodedString:publicKey];
    return [self RSAEncryptWithPublicKeyData:publicKeyData];
}

- (NSData *)RSAEncryptWithPublicKeyData:(NSData *)publicKeyData
{
    SecKeyRef publicKeyRef = [self checkCreatePublicSecKey:publicKeyData];
    
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKeyRef);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    memset(cipherBuffer, 0, cipherBufferSize);
    
    //使用分块加密，块长度[cipherBufferSize - 11]含义请查看rsa加密原理
    NSData *plainTextData = self;
    size_t blockSize = cipherBufferSize - 11;
    NSInteger numBlock = ceil(plainTextData.length/(double)blockSize);//块的个数，向上取整
    NSMutableData *encryptData = [[NSMutableData alloc] init];
    for (NSInteger i=0; i<numBlock; i++) {
        NSInteger bufferSize = MIN(blockSize, plainTextData.length - i * blockSize);
        NSData *buffer = [plainTextData subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(publicKeyRef, kSecPaddingPKCS1, buffer.bytes, buffer.length, cipherBuffer, &cipherBufferSize);
        if (noErr != status) {
            if (NULL != cipherBuffer) {
                free(cipherBuffer);
            }
#ifdef DEBUG
            NSAssert(noErr == status, @"SecKeyEncrypt failed...");
#endif
            return nil;
        }
        NSData *encryptedBytes = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
        [encryptData appendData:encryptedBytes];
    }//for
    
    if (NULL != cipherBuffer) {
        free(cipherBuffer);
    }
    
    return encryptData;
}

- (SecKeyRef)checkCreatePublicSecKey:(NSData *)publicKeyData
{
    SecCertificateRef certificateRef = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)(publicKeyData));
    NSAssert(nil != certificateRef, @"Read certificate failed...");
    
    SecPolicyRef policyRef = SecPolicyCreateBasicX509();
    SecTrustRef trustRef;
    OSStatus status = SecTrustCreateWithCertificates(certificateRef, policyRef, &trustRef);
    NSAssert(noErr == status, @"SecTrustCreateWithCertificates failed. Error Code: %d", status);
    
    SecTrustResultType trustResultType;
    status = SecTrustEvaluate(trustRef, &trustResultType);
    NSAssert(noErr == status, @"SecTrustEvaluate failed. Error Code: %d", status);
    
    SecKeyRef publicKeyRef = SecTrustCopyPublicKey(trustRef);
    NSAssert(nil != publicKeyRef, @"SecTrustCopyPublicKey failed...");
    
    CFRelease(certificateRef);
    CFRelease(policyRef);
    CFRelease(trustRef);
    
    return publicKeyRef;
}

- (NSData *)RSADecryptWithPrivateKey:(NSString *)privateKey password:(NSString *)password
{
    NSData *privateKeyData = [NSData dataWithBase64EncodedString:privateKey];
    return [self RSADecryptWithPrivateKeyData:privateKeyData password:password];
}

- (NSData *)RSADecryptWithPrivateKeyData:(NSData *)privateKeyData password:(NSString *)password
{
    SecKeyRef privateKeyRef = [self checkCreatePrivateSecKey:privateKeyData password:password];
    
    NSData *cipherData = self;
    size_t cipherDataLen = cipherData.length;
//    void *cipher = malloc(cipherDataLen);
//    [srcData getBytes:cipher length:cipherLen];
    
    size_t plainTextLen = SecKeyGetBlockSize(privateKeyRef) - 12;
    uint8_t *plainText = malloc(plainTextLen * sizeof(uint8_t));
    OSStatus status = SecKeyDecrypt(privateKeyRef, kSecPaddingPKCS1, cipherData.bytes, cipherDataLen, plainText, &plainTextLen);
    if (noErr != status) {
        if (NULL != plainText) {
            free(plainText);
        }
#ifdef DEBUG
        NSAssert(noErr == status, @"SecKeyDecrypt failed...");
#endif
        return nil;
    }
    NSData *decryptedData = [NSData dataWithBytes:plainText length:plainTextLen];
    
    if (NULL != plainText) {
        free(plainText);
    }
    
    return decryptedData;
}

- (SecKeyRef)checkCreatePrivateSecKey:(NSData *)privateKeyData password:(NSString *)password
{
    SecKeyRef privateKeyRef = NULL;
    
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:password forKey:(__bridge id<NSCopying>)(kSecImportExportPassphrase)];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    OSStatus status = SecPKCS12Import((__bridge CFDataRef)(privateKeyData), (__bridge CFDictionaryRef)(options), &items);
    NSAssert(noErr == status, @"SecPKCS12Import failed. Error Code: %d", status);
    NSAssert(CFArrayGetCount(items) > 0, @"SecPKCS12Import failed. CFArrayGetCount(items): %ld", CFArrayGetCount(items));
    
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef identityApp = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
    status = SecIdentityCopyPrivateKey(identityApp, &privateKeyRef);
    NSAssert(noErr == status, @"SecIdentityCopyPrivateKey failed. Error Code: %d", status);
    
    CFRelease(items);
    
    return privateKeyRef;
}

@end
