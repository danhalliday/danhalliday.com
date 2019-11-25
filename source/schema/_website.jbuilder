json.set! "@context", "https://schema.org"
json.set! "@type", "Website"

json.url data.site.url
json.name data.site.name
json.description data.site.description

json.author do
  json.set! "@type", "Person"
  json.name data.contact.name
end
