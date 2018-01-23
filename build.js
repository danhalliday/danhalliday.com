const fs = require("fs-extra")
const path = require("path")
const reshape = require("reshape")
const standard = require("reshape-standard")
const yaml = require("js-yaml")
const promisify = require("node-promisify")
const sass = require("node-sass")
const autoprefixer = require("autoprefixer")
const cssnano = require("cssnano")
const postcss = require("postcss")
const slug = require("slug")

slug.defaults.mode = "pretty"
slug.defaults.modes["pretty"].lower = true

const clean = async () => {
  await fs.remove("build")
}

const projects = async () => {
  const data = await fs.readFile("data/projects.yml")
  return yaml.load(data)
}

const homepage = async (context) => {
  const input = await fs.readFile("pages/index.html")
  const plugin = standard({ locals: context, parser: false, minify: true })
  const template = await reshape(plugin).process(input)
  await fs.ensureDir("build")
  await fs.writeFile("build/index.html", template.output())
}

const images = async () => {
  await fs.copy("images/", "build/images/")
}

const styles = async (production) => {
  const source = "styles/main.scss"
  const destination = "build/styles/main.css"
  const render = promisify(sass.render)
  const result = await render({ file: source, includePaths: ["styles"], outputStyle: "compressed" })
  const buildPath = path.join(process.cwd(), "build")
  const plugins = [autoprefixer(), cssnano({ preset: "advanced" })]
  const options = { from: source, to: destination }
  const optimised = await postcss(plugins).process(result.css, options)
  await fs.ensureDir(path.dirname(destination))
  await fs.writeFile(destination, optimised.css)
}

const build = async () => {
  console.time("build")
  await clean()
  const context = { projects: await projects(), slug }
  await homepage(context)
  await images()
  await styles()
  console.timeEnd("build")
}

if (module.parent) { module.exports = build }
else { build() }
