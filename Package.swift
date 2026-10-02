// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SignetCore",
    products: [
        .library(name: "SignetCore", targets: ["SignetCore"])
    ],
    targets: [
        .target(name: "SignetCore"),
        .testTarget(name: "SignetCoreTests", dependencies: ["SignetCore"])
    ]
)
