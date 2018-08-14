require "csv"
CSV.foreach(Rails.root.join "movies.csv") do |row|
  Movie.create(:id => row[0], :name => row[1])
end

CSV.foreach(Rails.root.join "ratings.csv") do |row|
  if row[2].to_i >= 4
    User.find_or_create_by(:id => row[0]).likes(Movie.find(row[1]))
  else
    User.find_or_create_by(:id => row[0]).dislikes(Movie.find(row[1]))
  end

  #Movie.create(:id => row[0], :name => row[1])
end