#import "SpecHelper.h"

#import "APIClientConfiguration.h"


SpecBegin(APIClientConfigurationSpecs)

__block APIClientConfiguration *_configuration;
__block NSURL *_baseURL;
__block APIHTTPClient *_httpClient;
__block APIRouter *_router;
__block APIJSONSerializer *_serializer;
__block APIMapper *_mapper;

beforeEach(^{
    _baseURL = [NSURL URLWithString:@"https://api.example.org"];
    _httpClient = [[APIHTTPClient alloc] initWithBaseURL:_baseURL sessionConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    _router = [[APIRouter alloc] init];
    _serializer = [[APIJSONSerializer alloc] init];
    _mapper = [[APIMapper alloc] init];
});

describe(@"APIClientConfiguration", ^{
    beforeEach(^{
        _httpClient = [[APIHTTPClient alloc] initWithBaseURL:_baseURL sessionConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
        _router = [[APIRouter alloc] init];
    });

    describe(@"configurationWithBlock:", ^{
        it(@"can be configured with a block", ^{
            _configuration = [APIClientConfiguration configurationWithBlock:^(APIClientConfiguration *configuration) {
                configuration.httpClient = _httpClient;
                configuration.router = _router;
                configuration.serializer = _serializer;
            }];

            expect(_configuration.httpClient).to.equal(_httpClient);
            expect(_configuration.router).to.equal(_router);
            expect(_configuration.serializer).to.equal(_serializer);
        });

        it(@"raises if no block was given", ^{
            expect(^{
                [APIClientConfiguration configurationWithBlock:nil];
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"raises if baseURL or httpClient was not set", ^{
            expect(^{
                [APIClientConfiguration configurationWithBlock:^(APIClientConfiguration *configuration) {}];
            }).to.raise(NSInternalInconsistencyException);
        });

        it(@"creates a httpClient if the baseURL is set", ^{
            _configuration = [APIClientConfiguration configurationWithBlock:^(APIClientConfiguration *configuration) {
                configuration.baseURL = _baseURL;
            }];

            expect(_configuration.baseURL).to.equal(_baseURL);
            expect(_configuration.httpClient.baseURL).to.equal(_baseURL);
        });
    });

    it(@"creates a default httpClient with the configured baseURL", ^{
        _configuration = [APIClientConfiguration configurationWithBaseURL:_baseURL];
        expect(_configuration.httpClient).to.beInstanceOf([APIHTTPClient class]);
        expect(_configuration.httpClient.baseURL).to.equal(_baseURL);
    });
    
    it(@"cannot be initialized without a baseURL", ^{
        expect(^{
            _configuration = [[APIClientConfiguration alloc] init];
        }).to.raise(NSInternalInconsistencyException);
    });

    it(@"has a default router", ^{
        _configuration = [APIClientConfiguration configurationWithBaseURL:_baseURL];
        expect(_configuration.router).to.beInstanceOf([APIRouter class]);
    });

    it(@"has a default serializer", ^{
        _configuration = [APIClientConfiguration configurationWithBaseURL:_baseURL];
        expect(_configuration.serializer).to.beInstanceOf([APIJSONSerializer class]);
    });

    it(@"has a default mapper", ^{
        _configuration = [APIClientConfiguration configurationWithBaseURL:_baseURL];
        expect(_configuration.mapper).to.beInstanceOf([APIMapper class]);
    });
});

SpecEnd
