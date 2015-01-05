---
layout: post
title : "Partner Apps"
date: 2015-01-05
author: Anthony Ross
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

The first step in connecting to Validic is to to have your organization credentials.  If you don't have those please contact [support@validic.com](mailto:support@validic.com).

If you're using a rails app we recommend storing your organization credentials into environment variables using something like [dotenv-rails.](https://github.com/bkeepers/dotenv)

#Gem Initializer & Set up

We recommend setting up an initializer for the gem so your calls automatically contain your organization's credentials.  In rails that would look like this(`config/initializers/validic.rb`)

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

#First Steps - User Provisioning

In order to send your users data you must provision users in Validic.  We recommend that you provision users once they authorize you to share their data in our marketplace.  Provisioning users looks like this:

{% highlight ruby %}
client = Validic::Client.new
response = client.user_provision(organization_id: ENV['VALIDIC_ORG_ID'], uid: 'YourUniqueIDAsAString')
{% endhighlight %}

That response will look like this:

{% highlight json %}
{
  "code": 201,
  "message": "Ok",
  "user": {
    "_id": "{USER_ID}",
    "access_token": "{USER_ACCESS_TOKEN}"
  }
}
{% endhighlight %}

You need to store the `_id` and `access_token` in your database as we'll use that information in the forthcoming POST calls. The entire provision user method might look like this:

{% highlight ruby %}
class User < ActiveRecord::Base
  def provision_validic
    client = Validic::Client.new
    self.uid = SecureRandom.urlsafe_base64 #random string
    resp = client.user_provision(organization_id: ENV['VALIDIC_ORG_ID'],
                                 uid: uid)
    self._id = resp.user._id
    self.access_token = resp.user.access_token
    self.save
  end
end

user = User.find(18) #find the user who just authorized
user.provision_validic #provision in Validic
{% endhighlight %}

#Posting Data to Validic

We're going to assume that once a user has authorized their data be shared with Validic you want to immediately send all new data of that users to Validic.  For instance, let's say we have an Activity class that once new data has been validated and saved on your server, it should also be pushed to Validic.  You can use a `after_save` hook in rails to do just that:

{% highlight ruby %}
class Activity < ActiveRecord::Base
  validates :steps, presence: true
  belongs_to :user
  after_save :push_to_validic

  def push_to_validic
    #you can do some check here to make sure user has authorized sending data to Validic
    client = Validic::Client.new
    Validic.user_id = self.user._id # we have this _id from the provision call above
    client.post_to_validic("routine", { routine: {
        timestamp: DateTime.now.utc.to_s(:iso8601),
        steps: self.steps,
        activity_id: self.unique_activity_id,
        extras: "{ \"points\": 10}"
      }
    })
  end
end
{% endhighlight %}

If a new activity is created here, it will send information to Validic using the generic `post_to_validic` method which takes the object we're posting (in this case 'routine') and sends in hash of fields.

