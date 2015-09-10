.PHONY: all setup

all:
	xcodebuild -workspace tvful.xcworkspace \
		-scheme tvful -sdk appletvsimulator

setup:
	bundle install
	bundle exec pod install --no-repo-update
