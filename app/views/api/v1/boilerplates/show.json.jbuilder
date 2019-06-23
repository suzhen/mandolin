json.partial! "api_v1_boilerplate", api_v1_boilerplate: @boilerplate
json.download @boilerplate.attachment_url.present? ? "http://#{@boilerplate.attachment_url}" : ""
