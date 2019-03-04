#import "AppCenter+Internal.h"
#import "MSDataStorageInternal.h"
#import "MSStorageIngestion.h"
#import "MSTokenExchange.h"
#import "MSTokensResponse.h"

NS_ASSUME_NONNULL_BEGIN

static NSString *const kMSPartitions = @"partitions";

@implementation MSTokenExchange : NSObject

+ (void)tokenAsync:(MSStorageIngestion *)httpClient
           partitions:(NSArray *)partitions
    completionHandler:(MSGetTokenAsyncCompletionHandler)completion {

  // Payload.
  NSError *jsonError;
  NSData *payloadData = [NSJSONSerialization dataWithJSONObject:@{kMSPartitions : partitions} options:0 error:&jsonError];

  // Http call.
  [httpClient sendAsync:payloadData
      completionHandler:^(NSString *callId, NSHTTPURLResponse *response, NSData *data, NSError *error) {
        MSLogVerbose([MSDataStorage logTag], @"Get token callback, request Id %@ with status code: %lu", callId,
                     (unsigned long)response.statusCode);

        // If comletion is provided.
        if (completion) {
          // Read tokens.
          NSError *tokenResponsejsonError;
          NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&tokenResponsejsonError];
          if (tokenResponsejsonError) {
            MSLogError([MSDataStorage logTag], @"Can't deserialize tokens with error: %@", [tokenResponsejsonError description]);
            completion([[MSTokensResponse alloc] initWithTokens:nil], error);
          }
          // Create token result object
          MSTokensResponse *tokens = [[MSTokensResponse alloc] initWithDictionary:jsonDictionary];
          completion(tokens, error);
        }
      }];
}

@end

NS_ASSUME_NONNULL_END
