const fs = require("fs-extra")
const path = require("path")
const glob = require("glob-promise")
const reshape = require("reshape")
const standard = require("reshape-standard")
const hfill = require("reshape-hfill")
const yaml = require("js-yaml")
const promisify = require("node-promisify")
const sass = require("node-sass")
const autoprefixer = require("autoprefixer")
const cssnano = require("cssnano")
const postcss = require("postcss")
const postcssUrl = require("postcss-url")
const inline = require("inline-source")
const slug = require("slug")
const sitemap = require("sitemap")

slug.defaults.mode = "pretty"
slug.defaults.modes["pretty"].lower = true

const reshapePlugins = [
  hfill({
    "headings": { "1-6": [ "h", "h1", "h2", "h3", "h4", "h5", "h6" ] }
  })
]

const postcssPlugins = [
  autoprefixer(),
  cssnano({ preset: "advanced" }),
  postcssUrl({ url: "inline" })
]

const clean = async () => {
  await fs.remove("build")
}

const data = async () => {
  return {
    site: yaml.load(await fs.readFile("data/site.yml")),
    about: yaml.load(await fs.readFile("data/about.yml")),
    technology: yaml.load(await fs.readFile("data/technology.yml")),
    design: yaml.load(await fs.readFile("data/design.yml")),
    companies: yaml.load(await fs.readFile("data/companies.yml")),
    projects: decorateProjects(yaml.load(await fs.readFile("data/projects.yml")))
  }
}

const decorateProjects = (projects) => {
  return projects.filter(p => !p.draft)
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
    const plugin = standard({ locals, parser: false, minify: true, appendPlugins: reshapePlugins })
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

const styles = async () => {
  const source = "styles/main.scss"
  const destination = "build/styles/main.css"
  const render = promisify(sass.render)
  const result = await render({ file: source, includePaths: ["styles"], outputStyle: "compressed" })
  const buildPath = path.join(process.cwd(), "build")
  const options = { from: source, to: destination }
  const optimised = await postcss(postcssPlugins).process(result.css, options)
  await fs.ensureDir(path.dirname(destination))
  await fs.writeFile(destination, optimised.css)
}

const createSitemap = async (context) => {
  const base = "build"
  const files = await glob(path.join(base, "**/*.html"))
  const urls = files
    .filter(includePageInSitemap)
    .map(file => path.dirname(path.relative(base, file)))
    .map(file => path.resolve(path.sep, file))
    .map(file => path.join(file, path.sep))
    .map(file => ({ url: file, changefreq: "monthly", priority: 1 }))

  const map = sitemap.createSitemap({
    hostname: context.site.host,
    urls: urls
  })

  await fs.ensureDir("build")
  await fs.writeFile(path.join("build", "sitemap.xml"), map.toString())
}

const includePageInSitemap = path => {
  return (
    path.includes("missing") === false &&
    path.includes("halliday-group") === false
  )
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
  await createSitemap(context)
  console.timeEnd("build")
}

if (module.parent) { module.exports = build }
else { build() }
