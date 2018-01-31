const fs = require("fs-extra")
const assert = require("assert")
const build = require("./build")

const files = [
  "build/index.html",
  "build/technology/index.html",
  "build/design/index.html",
  "build/companies/index.html",
  "build/styles/main.css"
]

const check = async () => {
  return Promise.all(files.map(fs.exists)).then(results => results.every(r => r == true))
}

build().then(check).then(assert).catch(error => { console.error(error); throw(error) })
