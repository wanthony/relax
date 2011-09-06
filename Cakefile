{exec} = require 'child_process'
fs = require 'fs'

task 'build', 'Build all coffee files in lib/', ->
  console.log "Building src/*.coffee into lib/*.js"
  exec 'coffee -c -o lib src', (e, stdout, stderr) ->
    console.log stdout
    console.log stderr

task 'test', 'Run the tests found in test/', ->
  invoke 'build'

  fs.readdir('./test', (e, files) ->
    for file in files
      console.log "Running test/#{file}"
      exec "coffee ./test/#{file}", (e, stdout, stderr) ->
        console.log stdout
        console.log stderr
  )
