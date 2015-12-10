.PHONY: all setup

all:
	xcodebuild -workspace tvful.xcworkspace \
		-scheme tvful -sdk appletvsimulator \
		-destination 'name=Apple TV 1080p'

setup:
	bundle install
	bundle exec pod install --no-repo-update
