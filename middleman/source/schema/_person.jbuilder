json.set! "@context", "https://schema.org"
json.set! "@type", "Person"

json.name data.contact.name
json.email data.contact.email
json.jobTitle data.contact.role
json.alumniOf data.contact.university
json.url data.site.url

json.image do
  json.set! "@type", "ImageObject"
  json.url URI.join(data.site.url, data.contact.portrait.url)
  json.width data.contact.portrait.width
  json.height data.contact.portrait.height
end

json.sameAs do
  json.array! data.contact.profiles
end

json.colleague do
  json.array! data.contact.colleagues
end

json.affiliation do
  json.array! data.companies do |company|
    json.set! "@type", "Organization"
    json.name company.name
    json.url company.website
  end
end
