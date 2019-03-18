// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

#import <Foundation/Foundation.h>

@class MSWrapperException;

/**
 * This class helps wrapper SDKs augment crash reports with additional data.
 *
 * HOW IT WORKS:
 * 1. Application is crashing from a wrapper SDK, but before propagating crash to the native code, it calls "saveWrapperException" which
 * saves the MSWrapperException to a file called "last_saved_wrapper_exception".
 * 2. On startup, the native SDK must find that file if it exists, and use the MSWrapperException's "pid" to correlate the file to a
 * PLCrashReport on disk. If a match is found, the file is renamed to the UUID of the PLCrashReport.
 * 3. When an MSAppleErrorLog must be generated, a corresponding MSWrapperException file is searched for, and if found, its MSException
 * property is added to the MSAppleErrorLog. The file is not deleted because there is an additional "data" property that contains
 * information that the wrapper SDK may want.
 * 4. When an MSErrorReport equivalent needs to be generated by a wrapper SDK, it is identical to the actual MSErrorReport, but also
 * includes the additional data that was saved. This data is accessed by "loadWrapperExceptionWithUUID".
 * Thus, the file on disk can only be deleted after all crash callbacks with an MSErrorReport parameter have completed.
 */
@interface MSWrapperExceptionManager : NSObject

/**
 * Save the MSWrapperException to the file "last_saved_wrapper_exception". This should only be used by a wrapper SDK; native code has no use
 * for it.
 */
+ (void)saveWrapperException:(MSWrapperException *)wrapperException;

/**
 * Load a wrapper exception from disk with a given UUID.
 */
+ (MSWrapperException *)loadWrapperExceptionWithUUIDString:(NSString *)uuidString;

@end
