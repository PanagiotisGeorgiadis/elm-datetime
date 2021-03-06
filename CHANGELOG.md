# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.3.0] - 2019-10-26
### Added
- Added `lastDayOf` function to the exposed Calendar and DateTime APIs.

## [1.2.0] - 2019-10-26
### Changed
- Changed the package's dependencies (npm) to fix vulnerability issues.

## [1.2.0] - 2019-04-07
### Added
- Added the fromZonedPosix function to the Internal Calendar module. ( Shouldn't be exposed )
- Added the fromZonedPosix function to the Internal Clock module. ( Shouldn't be exposed )
- Added the fromZonedPosix function to the Internal DateTime module. ( Shouldn't be exposed )
- Added the getTimezoneOffset function in the public DateTime module.
- Added unit tests for the getTimezoneOffset function.

## [1.1.0] - 2019-02-21
### Added
- Added setDate and setTime functions in the DateTime module.

## [1.0.1] - 2019-02-18
### Added
- Added Posix-to-Calendar and Posix-to-Clock assets.
- Added INSTALL file.

### Changed
- Changed the README file.
- Changed the Flow-Diagram asset file.

## [1.0.0] - 2019-02-16
### Added
- Added the implementation of the Calendar module.
- Added the implementation of the Clock module.
- Added the implementation of the DateTime module.
- Added unit tests for the Calendar module.
- Added unit tests for the Clock module.
- Added unit tests for the DateTime module.
- Added documentation comments for the Calendar module.
- Added documentation comments for the Clock module.
- Added documentation comments for the DateTime module.

### Changed
- Changed the Licence of the project from MIT to BSD 3-Clause.
- Changed the LICENCE filename to LICENSE.
