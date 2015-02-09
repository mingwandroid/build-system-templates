import qbs

CppApplication {
    type: "application" // To suppress bundle generation on Mac
    consoleApplication: true
    files: [
        "src/helloworld.cpp",
        "src/helloworld.h",
        "src/main.cpp",
    ]
    
    Group {     // Properties for the produced executable
        fileTagsFilter: product.type
        qbs.install: true
    }
}

