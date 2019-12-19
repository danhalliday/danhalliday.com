json.set! "@context", "http://schema.org"

json.set! "@graph" do
  json.array! data.companies do |company|
    json.set! "@type", "Organization"
    json.name company.name
    json.url company.website
  end
end
