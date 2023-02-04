//
//  ReceiptValidator.h
//  Tercer
//
//  Created by krunal on 21/09/22.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
//#import "Story_Downloader-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiptValidator : NSObject
-(void)helloWorld;
- (BOOL)verifyReceipt:(SKPaymentTransaction *)transaction;
@end

NS_ASSUME_NONNULL_END
