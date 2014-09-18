# cocoapods-coverage

A [CocoaPods][3] plugin which generates code coverage statistics for Pods.

## Installation

    $ gem install cocoapods-coverage

## Usage

    $ pod lib coverage

This will run all your tests and compute coverage information. Locally, you will see a textual summary whereas on [Travis CI][1], the statistics will get uploaded to [Coveralls][2].

[1]: http://travis-ci.org
[2]: http://coveralls.io
[3]: http://cocoapods.org
