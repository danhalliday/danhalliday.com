const fs = require("fs-extra")
const path = require("path")
const glob = require("glob-promise")
const reshape = require("reshape")
const standard = require("reshape-standard")
const yaml = require("js-yaml")
const promisify = require("node-promisify")
const sass = require("node-sass")
const autoprefixer = require("autoprefixer")
const cssnano = require("cssnano")
const postcss = require("postcss")
const inline = require("inline-source")
const slug = require("slug")

slug.defaults.mode = "pretty"
slug.defaults.modes["pretty"].lower = true

const clean = async () => {
  await fs.remove("build")
}

const data = async () => {
  const about = await fs.readFile("data/about.yml")
  const technology = await fs.readFile("data/technology.yml")
  const design = await fs.readFile("data/design.yml")
  const companies = await fs.readFile("data/companies.yml")
  const services = await fs.readFile("data/services.yml")

  return {
    about: yaml.load(about),
    technology: yaml.load(technology),
    design: yaml.load(design),
    companies: yaml.load(companies),
    services: yaml.load(services)
  }
}

const pages = async (context) => {
  const pages = await glob("pages/**/*.html")

  const tasks = pages.map(async (page) => {
    const id = path.basename(page, path.extname(page))
    const directory = path.relative("pages", path.dirname(page))
    const file = (id == "index") ? "index.html" : `${id}/index.html`
    const destination = path.join("build", path.join(directory, file))

    const locals = Object.assign({ id }, context)
    const input = await fs.readFile(page)
    const plugin = standard({ locals, parser: false, minify: true })
    const template = await reshape(plugin).process(input)
    const html = await inline.inlineSource(template.output(), {
      compress: true, rootpath: path.resolve("build"), attribute: "data-d-inline"
    })

    await fs.ensureDir(path.dirname(destination))
    await fs.writeFile(destination, html)
  })

  await Promise.all(tasks)
}

const images = async () => {
  await fs.copy("images", "build/images")
}

const general = async () => {
  await fs.copy("general", "build")
}

const fonts = async () => {
  await fs.copy("fonts", "build/fonts")
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
  const context = { ...await data(), slug }
  await images()
  await pages(context)
  await styles()
  await fonts()
  await general()
  console.timeEnd("build")
}

if (module.parent) { module.exports = build }
else { build() }
