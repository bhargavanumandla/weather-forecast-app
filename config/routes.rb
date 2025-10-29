Rails.application.routes.draw do
  root "weather#index"
  get  "forecast", to: "weather#show"
  post "forecast", to: "weather#show"
end
