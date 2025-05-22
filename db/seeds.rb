print "Cleaning database..."
# First destroy bookmarks (child records) before destroying parent records
Bookmark.destroy_all
# Then destroy parent records
Movie.destroy_all
List.destroy_all
puts "Database cleaned!"

require "open-uri"
require "json"
require "faker"

print "Creating movies..."
url = "https://tmdb.lewagon.com/movie/top_rated"
user_serialized = URI.open(url).read
movies = JSON.parse(user_serialized)["results"]
  movies.first(100).each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original/#{movie['poster_path']}",
    rating: movie["vote_average"]
  )
end

puts "Creating movies done!"
print "Creating lists..."

# Create some lists
List.create!(name: "Action Movies")
List.create!(name: "Romantic Movies")
List.create!(name: "Comedy Movies")

puts "Creating lists done!"
print "Creating bookmarks..."

# Create some bookmarks
20.times do
  Bookmark.create(comment: Faker::Name.name, list: List.all.sample, movie: Movie.all.sample)
end

puts "Seed Done!!"
