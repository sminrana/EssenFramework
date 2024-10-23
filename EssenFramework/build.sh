#!/bin/bash

FrameworkName="EssenFramework"

rm -rf build/

xcodebuild archive -scheme "$FrameworkName" \
	-configuration Release \
	-destination 'generic/platform=iOS' \
	-archivePath "./build/$FrameworkName.framework-iphoneos.xcarchive" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

xcodebuild archive -scheme "$FrameworkName" \
	-configuration Release \
	-destination 'generic/platform=iOS Simulator' \
	-archivePath "./build/$FrameworkName.framework-iphonesimulator.xcarchive" \
	SKIP_INSTALL=NO \
	BUILD_LIBRARIES_FOR_DISTRIBUTION=YES

# Fix https://bugs.swift.org/browse/SR-14195 (caused by https://bugs.swift.org/browse/SR-898)
#pattern="./build/$FrameworkName.framework-iphoneos.xcarchive/Products/Library/Frameworks/$FrameworkName.framework/Modules/$FrameworkName.swiftmodule/*.swiftinterface"
#grep -rli "$FrameworkName.$FrameworkName" $pattern \
#        | xargs sed -i '' "s,$FrameworkName.$FrameworkName,$FrameworkName,g"
# end fix

xcodebuild -create-xcframework \
	-framework "./build/$FrameworkName.framework-iphoneos.xcarchive/Products/Library/Frameworks/$FrameworkName.framework" \
	-framework "./build/$FrameworkName.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/$FrameworkName.framework" \
	-output "./build/$FrameworkName.xcframework"

# Wait for process completion and verify result
pid=$!
wait $pid
echo "Process with PID $pid has finished with Exit status: $?"
[[ ! -d "./build/$FrameworkName.xcframework/" ]] && {
	msg="[ERROR] expected ./build/$FrameworkName.xcframework/ to exist"
	echo -e $msg
	exit 1
}
