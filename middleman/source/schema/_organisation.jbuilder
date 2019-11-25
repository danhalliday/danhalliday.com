json.set! "@context", "https://schema.org"
json.set! "@type", "Organization"

json.name "Halliday Group"
json.legalName "Halliday Group Limited"
json.url "https://halliday.group"

json.logo do
  json.set! "@type", "ImageObject"
  json.url URI.join(data.site.url, data.contact.portrait.url)
  json.width data.contact.portrait.width
  json.height data.contact.portrait.height
end

json.foundingDate "2015"

json.founders do
  json.set! "@type", "Person"
  json.name "Dan Halliday"
end

json.contactPoint do
  json.set! "@type", "ContactPoint"
  json.contactType "office"
  json.email "info@halliday.group"
  json.url "https://halliday.group"
  json.areaServed "GB"
  json.availableLanguage "English"
end
