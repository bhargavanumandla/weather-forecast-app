# 🌤 Weather Forecast App

A simple Ruby on Rails web application that provides real-time weather information for any address, city, or ZIP code.  
Built with **Ruby 3.2.3** and **Rails 7.1.5**, using **PostgreSQL** as the database.

---

## 🚀 Features

- Search weather by **city**, **ZIP code**, or **address**.
- Uses **Geocoder** to resolve user input to coordinates or postal codes.
- Fetches live weather data from an external **Weather API** (via Faraday HTTP client).
- Gracefully handles invalid addresses and API errors.
- Responsive, clean user interface with basic CSS styling.

---

## 🛠 Tech Stack

| Component        | Version  | Purpose |
|------------------|-----------|----------|
| Ruby             | 3.2.3     | Programming language |
| Rails            | 7.1.5     | Web framework |
| PostgreSQL       | 15+       | Database |
| Faraday          | ~> 2.8    | API HTTP client |
| Geocoder         | ~> 1.8    | Geocoding service |
| dotenv-rails     | ~> 3.1    | Environment variable management |

---

## ⚙️ Setup Instructions

1. **Clone the repository**

   ```bash
   git clone https://github.com/bhargavanumandla/weather-forecast-app.git
   cd weather-forecast-app
   ```

2. **Install dependencies**

   ```bash
   bundle install
   ```

3. **Set up your database**

   ```bash
   rails db:create db:migrate
   ```

4. **Create your `.env` file**

   Add your API key inside a `.env` file at the project root:

   ```bash
   WEATHER_API_KEY=your_openweathermap_api_key
   ```

5. **Start the server**

   ```bash
   rails server
   ```

6. **Visit the app**

   Go to [http://localhost:3000](http://localhost:3000)

---

## 🧠 Code Structure

```
app/
  controllers/
    weather_controller.rb   # Handles search and forecast display
  views/
    weather/
      index.html.erb        # Search form
      show.html.erb         # Displays forecast results
  services/
    weather_client.rb       # Handles Weather API communication
```

---

## 🌍 Example Usage

1. Enter an address, city, or ZIP code (e.g., “London”, “10001”, or “1600 Amphitheatre Pkwy”).
2. Click **Get Forecast**.
3. View current weather conditions such as temperature, humidity, and condition summary.

---

## 🧪 Development Notes

- Uses **Faraday** for clean, testable HTTP requests.
- Implements structured error handling for Weather API failures.
- Compatible with **Windows**, **macOS**, and **Linux** development environments.

