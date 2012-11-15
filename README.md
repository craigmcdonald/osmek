# Osmek

Osmek is a gem to interface your Ruby application with the [Osmek](http://osmek.com) Content API.

## Installation

Add this line to your application's Gemfile:

    gem 'osmek'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install osmek

## Usage

    require 'osmek'

    # Coming soon

## Contributing

To run tests, you will need to set some environment varaibles like `API_KEY`, `USERNAME` and `PASSWORD`.
You can do that by creating a `.env` file in the root of the project with this content:

```
API_KEY=<your_api_key>
USERNAME=<your_email_address>
PASSWORD=<your_password_and_account_id_as_an_md5_hash>
```

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
