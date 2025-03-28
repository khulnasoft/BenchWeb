# Package

version       = "0.1.0"
author        = "Dominik Picheta"
description   = "KhulnaSoft Jester benchmark."
license       = "MIT"

bin           = @["khulnasoft"]
skipExt = @["nim"]

# Dependencies

requires "nim >= 1.0.0"

# We lock dependencies here on purpose.
requires "httpbeast#v0.4.0"
requires "jester 0.5.0"
