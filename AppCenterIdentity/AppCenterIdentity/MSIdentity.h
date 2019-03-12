#import "MSServiceAbstract.h"
#import "MSUserInformation.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Completion handler triggered when sign-in completed.
 *
 * @param userInformation User information for signed in user.
 * @param error Error for sign-in failure.
 */
typedef void (^MSSignInCompletionHandler)(MSUserInformation *_Nullable userInformation, NSError *_Nullable error);

/**
 * Error code for Identity.
 */
typedef NS_ENUM(NSInteger, MSIdentityErrorCode) {
  MSIdentityErrorServiceDisabled = -420000,
  MSIdentityErrorPreviousSignInRequestInProgress = -420001,
  MSIdentityErrorSignInBackgroundOrNotConfigured = -420002,
  MSIdentityErrorSignInWhenNoConnection = -420003
};

/**
 * Error domain for Identity.
 */
static NSString *const MSIdentityErrorDomain = @"MSIdentityErrorDomain";

/**
 * Error description key for Identity.
 */
static NSString *const MSIdentityErrorDescriptionKey = @"MSIdentityErrorDescriptionKey";

/**
 * App Center Identity service.
 */
@interface MSIdentity : MSServiceAbstract

/**
 * Process URL request for the service.
 *
 * @param URL  The URL with parameters.
 *
 * @return `YES` if the URL is intended for App Center Identity and your application, `NO` otherwise.
 *
 * @discussion Place this method call into your app delegate's openURL method.
 */
+ (BOOL)openURL:(NSURL *)URL;

/**
 * Sign-in to get user information.
 *
 * @param completionHandler Callback that is invoked after sign-in completed. @c `MSSignInCompletionHandler`.
 */
+ (void)signInWithCompletionHandler:(MSSignInCompletionHandler _Nullable)completionHandler;

/**
 * Sign out to clear user information.
 */
+ (void)signOut;

/**
 * Sets the base URL for the remote configuration file.
 *
 * @param configURL The base URL of the remote configuration file.
 */
+ (void)setConfigURL:(NSString *)configURL;

@end

NS_ASSUME_NONNULL_END
