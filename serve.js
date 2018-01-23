const browsersync = require("browser-sync").create()
const chokidar = require("chokidar")
const build = require("./build")

var building = false

const ignored = [
  /node_modules/, /build/, /\.git/
]

const watchOptions = {
  ignored: ignored,
  ignoreInitial: true
}

const serveOptions = {
  server: "build",
  notify: false
}

const change = async (event, file) => {
  console.log("change")
  if (building) { return }
  building = true
  build()
    .then(() => { browsersync.reload() })
    .catch(console.error)
    .then(() => { building = false })
}

chokidar.watch(".", watchOptions)
  .on("ready", change)
  .on("all", change)

browsersync.init(serveOptions)
