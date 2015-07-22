begin
Geocoder.configure(

  # geocoding service (see below for supported options):
  lookup: :google,
  use_https: true,

  :google => {
    api_key: "AIzaSyDXisOrjsA8EKH7jz9UEXV2TtUu5GeKAdo"
  }

  # IP address geocoding service (see below for supported options):
  #:ip_lookup => :maxmind,

  # to use an API key:

  # geocoding service request timeout, in seconds (default 3):
  #:timeout => 5,

  # set default units to kilometers:
  #:units => :km,

  # caching (see below for details):
  #:cache => Redis.new,
  #:cache_prefix => "..."

)
end
