FactoryGirl.define do
  factory :user do
    username     "yeyms"
    first_name   "dood"
    last_name	"this"
    password "one"
    password_confirmation "one"
    walldate Time.now
    interests "stuff"
    quotes "quotez"
  end
end

