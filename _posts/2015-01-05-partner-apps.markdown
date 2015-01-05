---
layout: post
title : "This is a post about partner apps"
date: 2015-01-05
categories: validic partner
---

##Getting started

The purpose of this post is two fold - 1.)  set up  Partner Application in Validic and 2.) use the [Validic Ruby Gem](https://github.com/validic/validic).

#Install the gem

You can add the gem to your Gemfile

{% highlight ruby %}
gem 'validic'
{% endhighlight %}

then run `bundle install`

#Credentials

The first step in connecting to Validic is to to have your organization credentials.  If you don't have those please contact [support@validic.com](mailto:support@validic.com)

If you're using a rails app we recommend storing your organization credentials into environment variables using something like [dotenv-rails.](https://github.com/bkeepers/dotenv)

#Gem Initializer & Set up

We recommend setting up an initializer for the gem so your calls automatically contain your organizaton's credentials.  In rails that would look like this:

{% highlight ruby %}
Validic.configure do |config|
  config.api_url        = 'https://api.validic.com'
  config.api_version    = 'v1'
  config.organization_id = ENV['VALIDIC_ORG_ID']
  config.access_token = ENV['VALIDIC_ACCESS_TOKEN']
end
{% endhighlight %}

Subsequently this requires you create a `.env` file with your credentials:

{% highlight ruby %}
VALIDIC_ORG_ID=YOUR_ORG_ID_HERE
VALIDIC_ACCESS_TOKEN=YOUR_ACCESS_TOKEN_HERE
{% endhighlight %}

#First Steps


