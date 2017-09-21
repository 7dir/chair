require 'erb'
require "awesome_print"

require "json"
require "json-schema"

schema = {
  "type" => "object",
  "required" => ["a"],
  "properties" => {
    "a" => {"type" => "integer"}
  }
}

#
# validate ruby objects against a ruby schema
#

# => true
puts JSON::Validator.validate(schema, { "a" => 5 })
# => false
# JSON::Validator.validate(schema, {})

#
# validate a json string against a json schema file
#

File.write("schema.json", JSON.dump(schema))

# => true
JSON::Validator.validate('schema.json', '{ "a": 5 }')

#
# raise an error when validation fails
#

# => "The property '#/a' of type String did not match the following type: integer"
begin
  JSON::Validator.validate!(schema, { "a" => "taco" })
rescue JSON::Schema::ValidationError => e
  e.message
end

#
# return an array of error messages when validation fails
#

# => ["The property '#/a' of type String did not match the following type: integer in schema 18a1ffbb-4681-5b00-bd15-2c76aee4b28f"]
JSON::Validator.fully_validate(schema, { "a" => "taco" })
