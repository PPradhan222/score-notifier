module Spiders
  class ApplicationSpider < Kimurai::Base
    @engine = :selenium_chrome
    @config = {
      disable_images: true,
      retry_request_errors: false
    }
  end
end
