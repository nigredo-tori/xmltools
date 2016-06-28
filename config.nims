version       = "0.0.3"
author        = "Anatoly Galiulin <galiulin.anatoly@gmail.com>"
description   = "High level xml library for Nim"
license       = "MIT"

srcdir        = "src"

requires "nim >= 0.13.1", "nimfp >= 0.0.7", "nimboost >= 0.0.1"

proc buildBase(debug: bool, bin: string, src: string) =
  switch("out", (thisDir() & "/" & bin).toExe)
  --nimcache: build
  if not debug:
    --forceBuild
    --define: release
    --opt: size
  else:
    --define: debug
    --debuginfo
    --debugger: native
    --linedir: on
    --stacktrace: on
    --linetrace: on
    --verbosity: 1

    --NimblePath: src
    --NimblePath: srcdir
    
  setCommand "c", src

proc test(name: string) =
  if not dirExists "bin":
    mkDir "bin"
  --run
  buildBase true, "bin/test_" & name, "tests/test_" & name

task test, "Run all tests":
  test "all"
