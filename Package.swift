// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "Tachi2Eamuse",
    platforms: [
        .macOS(.v11)
    ],
    products: [
        .executable(name: "tachiToeAmuse", targets: ["tachiToeAmuse"]),
    ],
    dependencies: [
        .package(url: "https://github.com/yaslab/CSV.swift.git", .upToNextMinor(from: "2.4.3"))
    ],
    
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .executableTarget(
            name: "tachiToeAmuse",
            dependencies: [.product(name: "CSV", package: "CSV.swift")])
    ]
)