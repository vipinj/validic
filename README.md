# Validic #

Ruby API Wrapper for [Validic](http://www.validic.com). It includes the
following functionality:

### Organization ###
- General information on organization
- Summary object of response
- Organization data (i.e. provisioned users, activities)

### Users ###
- Provision new Validic users
- Update or Suspend users
- Delete users
- Users based on authentication tokens
- Me call for id from authentication token
- Refresh user authentication token *Not yet implemented*

### Profiles ###
- Get profile information from authentication token
- Create new profiles *Not yet implemented*

### Fitness, Routine, Nutrition, Sleep, Weight, Diabetes, Biometrics, Tobacco Cessation ###
- Get activities scoped to user or organization
- Create activities *In progress*
- Activities from specific sources
- Specified time ranges
- Expanded data

### Latest Endpoint ###
- Latest data recorded, regardless of when the activity occurred
- Between designated start and end points

## Build Status
[![Codeship Status for Validic/validic](https://www.codeship.io/projects/cc4ff330-9f72-0130-3cf3-0e5a3e2104f7/status?branch=master)](https://www.codeship.io/projects/3456)

## Stable Version: 0.3.2

## Installation

Add this line to your application's Gemfile:

    gem 'validic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validic

## Usage

First, instantiate the client.
```ruby
    require 'validic'

    # If you're using Rails 3+
    # config/initializers/validic.rb
    Validic.configure do |config|
      config.api_url          = 'https://api.validic.com'
      config.api_version      = 'v1'
      config.access_token     = 'ORGANIZATION_ACCESS_TOKEN'
      config.organization_id  = 'ORGANIZATION_ID'
    end

    # Create a Client Object expecting you have an initializer in place
    validic = Validic::Client.new

    # If you're using plain RUBY
    # Create Validic::Client Object
    options = {
      api_url:         'https://api.validic.com',
      api_version:     'v1',
      access_token:    'ORGANIZATION_ACCESS_TOKEN'
      organization_id: 'ORGANIZATION_ID'
    }
    validic = Validic::Client.new options
```

Now you can use the wrapper's helper methods to interface with the Validic API.
```ruby
# Get current organization metadata
validic.get_organization
```

The wrapper returns the JSON response as a Hashie::Mash instance for easy
manipulation.
```ruby
# Get an array of apps for my current organization
validic.get_apps.apps.map(&:name)
```

You can pass a hash of options to calls that fetch data.
```ruby
validic.get_routine(start_date: '2015-01-01T00:00:00+00:00')
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
