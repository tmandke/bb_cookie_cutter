unless Rails.env.test?
  BbCookieCutter.backbonify Post
end
