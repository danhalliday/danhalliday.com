json.set! "@context", "https://schema.org"
json.set! "@type", "Article"

json.headline article.title
json.datePublished article.date.to_date.iso8601
json.image article.data.image

json.author do
  json.set! "@type", "Person"
  json.name data.contact.name
end
