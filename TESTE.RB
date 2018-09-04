require 'pp'
# require "csv"
# CSV.foreach(Rails.root.join "movies.csv") do |row|
#   Movie.create(:id => row[0], :name => row[1])
# end
#
# CSV.foreach(Rails.root.join "ratings.csv") do |row|
#   if row[2].to_i >= 4
#     User.find_or_create_by(:id => row[0]).likes(Movie.find(row[1]))
#   else
#     User.find_or_create_by(:id => row[0]).dislikes(Movie.find(row[1]))
#   end
#
#   #Movie.create(:id => row[0], :name => row[1])
# end
puts [10506].join("_")
require 'pp'
class Score
  attr_accessor :total, :total2, :partial, :count
#  h = c.total.reject{|k| k[1]<20}.map{|x| [x[0].name, x[1].fdiv(x[0].votes_for.up.count)]}

  def gs(id)
    t = Time.now
    things = []
    k = 0
    Movie.find(id).votes_for.up.voters.each do |user|
      k+=1
      things += user.find_liked_items.map(&:name)
      #break if things.count >= 10000
    end
    self.count = k
    self.total = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 100
    p things.count
    p Time.now - t
  end

  def gc(id)
    t = Time.now
    things = []
    k = 0
    movie = Movie.find(id)
    tags = movie.tags
    movie.votes_for.up.voters.each do |user|
      k+=1
      things += Movie.where(:id => user.votes.pluck(:votable_id)).any_tags(tags).map(&:name)
      #things += user.find_liked_items.map(&:name)
      #break if things.count >= 10000
    end
    self.count = k
    self.total = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 100
    p things.count
    p Time.now - t
  end


  def gd(id)
    t = Time.now
    things = []
    k = 0
    movie = Movie.find(id)
    tags = movie.tags
    movie.votes_for.up.voters.each do |user|
      k+=1
      things += Movie.where(:id => user.votes.pluck(:votable_id)).any_tags(tags)#.map(&:name)
      #things += user.find_liked_items.map(&:name)
      #break if things.count >= 10000
    end
    self.count = k
    #self.total = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 100
    self.total =  Hash[things.group_by(&:itself).map{|k, v| [k, v.size]}].sort_by{|_,v| v}.reverse#.take 100
    p things.count
    p Time.now - t
  end
  def gz(id)
    t = Time.now
    things = []
    k = 0
    Movie.find(id).votes_for.up.voters.each do |user|
      k+=1
      things += user.votes.up.map(&:votable_id)
      #break if things.count >= 8000
    end
    self.count = k
    self.total = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 15
    p things.count
    p Time.now-t
  end
  def ge(id)
    t = Time.now
    things = []
    k = 0
    Movie.find(id).votes_for.up.voters.each do |user|
      k+=1
      things += user.votes.down.map(&:votable_id)
      #break if things.count >= 8000
    end
    self.count = k
    self.total2 = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 15
    p things.count
    p Time.now-t
  end
  def gg(id, x)
    t = Time.now
    things = []
    Movie.find(id).votes_for.up.voters.sort_by{|user| user.total_likes}.reverse.take(x).each do |user|
      things += user.find_liked_items.map(&:name)
    end
    self.partial = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 15
    p things.count
    p Time.now-t
  end

  def gt(id, x)
    t = Time.now
    things = []
    Movie.find(id).votes_for.up.voters.sort_by{|user| user.total_likes}.take(x).each do |user|
      things += user.find_liked_items.map(&:name)
      if things.uniq.size > 1000
        k = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.map{|x| x.first}.take(things.uniq.size - 1000)
        things.reject!{|p| k.include?(p)}
      end
    end
    self.partial = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 15
    p things.count
    p Time.now-t
  end
end

c = Score.new

user = nil
anterior = 0
count = 0
CSV.foreach(Rails.root.join('ratings.csv')) do |row|
if row[0].to_i >= 3508
  if row[0].to_i != anterior
    #User.find(anterior).update(:total_likes => count)
    #count = 0
    anterior = row[0].to_i
    user = User.find(row[0].to_i)
  end
  if row[2].to_i < 4
    user.dislikes Movie.find(row[1].to_i)
    count += 1
  end
end
end

class Score
  attr_accessor :total, :total2, :partial, :count
  def gu(id)
    t = Time.now
    things = []
    k = 0
    movie = Movie.find(id)
    tags = movie.tags
    movie.votes_for.up.voters.each do |user|
      k+=1
      things += Movie.where(:id => user.votes.up.pluck(:votable_id)).any_tags(tags)#.map(&:name)
      #things += user.find_liked_items.map(&:name)
      #break if things.count >= 10000
    end
    self.count = k
    #self.total = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 100
    self.total =  Hash[things.group_by(&:itself).map{|k, v| [k, v.size]}].sort_by{|_,v| v}.reverse#.take 100
    p things.count
    p Time.now - t
  end
  def gd(id)
    t = Time.now
    things = []
    k = 0
    movie = Movie.find(id)
    tags = movie.tags
    movie.votes_for.up.voters.each do |user|
      k+=1
      things += Movie.where(:id => user.votes.down.pluck(:votable_id)).any_tags(tags)#.map(&:name)
      #things += user.find_liked_items.map(&:name)
      #break if things.count >= 10000
    end
    self.count = k
    #self.total = things.uniq.map{|t| [t,things.count(t)]}.to_h.sort_by{|_,v| v}.reverse.take 100
    self.total =  Hash[things.group_by(&:itself).map{|k, v| [k, v.size]}].sort_by{|_,v| v}.reverse#.take 100
    p things.count
    p Time.now - t
  end
end
c = Score.new
