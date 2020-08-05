// swift-tools-version:5.0

// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License.

import PackageDescription

let package = Package(
    name: "App Center",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "AppCenterAnalytics",
            type: .static,
            targets: ["AppCenterAnalytics"]),
        .library(
            name: "AppCenterCrashes",
            type: .static,
            targets: ["AppCenterCrashes"])
    ],
    dependencies: [
        // TODO replace commit hash to released version before release.
        .package(url: "https://github.com/microsoft/plcrashreporter.git", .revision("ec31c6c3017854c57736bac2b0d174eecef920cb")),
    ],
    targets: [
        .target(
            name: "AppCenter",
            path: "AppCenter/AppCenter",
            exclude: ["Support"],
            cSettings: [
                .define("APP_CENTER_C_VERSION", to:"\"3.3.3\""),
                .define("APP_CENTER_C_BUILD", to:"\"1\""),
                .headerSearchPath(""),
                .headerSearchPath("Internals"),
                .headerSearchPath("Internals/Channel"),
                .headerSearchPath("Internals/Context"),
                .headerSearchPath("Internals/Context/Device"),
                .headerSearchPath("Internals/Context/Session"),
                .headerSearchPath("Internals/Context/UserId"),
                .headerSearchPath("Internals/DelegateForwarder"),
                .headerSearchPath("Internals/HttpClient"),
                .headerSearchPath("Internals/HttpClient/Util"),
                .headerSearchPath("Internals/Ingestion"),
                .headerSearchPath("Internals/Ingestion/Util"),
                .headerSearchPath("Internals/Model"),
                .headerSearchPath("Internals/Model/CommonSchema"),
                .headerSearchPath("Internals/Model/Properties"),
                .headerSearchPath("Internals/Model/Util"),
                .headerSearchPath("Internals/Storage"),
                .headerSearchPath("Internals/Util"),
                .headerSearchPath("Internals/Vendor"),
                .headerSearchPath("Internals/Vendor/Reachability"),
                .headerSearchPath("Model")
            ],
            linkerSettings: [
                .linkedLibrary("z"),
                .linkedLibrary("sqlite3"),
                .linkedFramework("Foundation"),
                .linkedFramework("SystemConfiguration"),
                .linkedFramework("AppKit", .when(platforms: [.macOS])),
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("CoreTelephony", .when(platforms: [.iOS, .macOS])),
            ]
        ),
        .target(
            name: "AppCenterAnalytics",
            dependencies: ["AppCenter"],
            path: "AppCenterAnalytics/AppCenterAnalytics",
            exclude: ["Support"],
            cSettings: [
                .headerSearchPath(""),
                .headerSearchPath("Internals"),
                .headerSearchPath("Internals/Model"),
                .headerSearchPath("Internals/Session"),
                .headerSearchPath("Internals/Util"),
                .headerSearchPath("Model"),
                .headerSearchPath("TransmissionTarget"),
                .headerSearchPath("../../AppCenter/AppCenter"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Channel"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context/Device"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context/Session"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context/UserId"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/DelegateForwarder"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/HttpClient"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/HttpClient/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Ingestion"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Ingestion/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model/CommonSchema"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model/Properties"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Storage"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Vendor"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Vendor/Reachability"),
                .headerSearchPath("../../AppCenter/AppCenter/Model")
            ],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("AppKit", .when(platforms: [.macOS])),
            ]
        ),
        .target(
            name: "AppCenterCrashes",
            dependencies: ["AppCenter", "CrashReporter"],
            path: "AppCenterCrashes/AppCenterCrashes",
            exclude: ["Support"],
            cSettings: [
                .headerSearchPath(""),
                .headerSearchPath("Internals"),
                .headerSearchPath("Internals/Model"),
                .headerSearchPath("Internals/Util"),
                .headerSearchPath("Model"),
                .headerSearchPath("WrapperSDKUtilities"),
                .headerSearchPath("../../AppCenter/AppCenter"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Channel"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context/Device"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context/Session"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Context/UserId"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/DelegateForwarder"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/HttpClient"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/HttpClient/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Ingestion"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Ingestion/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model/CommonSchema"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model/Properties"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Model/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Storage"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Util"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Vendor"),
                .headerSearchPath("../../AppCenter/AppCenter/Internals/Vendor/Reachability"),
                .headerSearchPath("../../AppCenter/AppCenter/Model")
            ],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("AppKit", .when(platforms: [.macOS])),
            ]
        )
    ]
)
