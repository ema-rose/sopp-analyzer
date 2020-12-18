require 'csv'
require 'set'
require 'date'
require 'time'

def outcome_types(filename, cat)
    result = Set.new
    # Note that:
    # %i[numeric date] == [:numeric, :date]
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        result << row[cat]
    end
    return result
end

def any_type_hash(filename, key)
    # key is the name of any column header for a row
    result = Hash.new(0)
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        result[row[key]] += 1
    end
    return result
end

def day_of_week(filename)
    result = Hash.new(0)
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        date = row['date']
        result[date.cwday] += 1
    end
    return result
end

def hour(time)
    return time.split(':')[0].to_i
end

def parse_all(filename)
    outcomes = Hash.new(0)
    days = Hash.new(0)
    hours = Hash.new(0)
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        outcomes[row['outcome']] += 1
        days[row['date'].cwday] += 1
        hours[hour(row['time'])] += 1
    end
    puts outcomes
    puts days
    puts hours
end

def contains(filename, col, key)
    #check if a string is contained in any of 
    #the types for a column
    outcome_types(filename, col).each do |x| 
        if x.downcase.include? key
            puts x + "\n"
            return true
        end
    end
    return false
end

def count(filename, col)
    #count total in column
    count = 0
    CSV.foreach(filename, headers: true, converters: %i[numeric date]) do |row|
        while row.any? == true
            count +=1
        end
    end
end




if __FILE__ == $0
    tn = 'tn.csv'
    mt = 'mt.csv'
    
    #FIND compare different types of violations
    
    #here, we're returning the possible outcome types for
    #both states
=begin
    num = 0
    outcome_types(tn, 'violation').each do |x| 
        puts num
        puts ": " + x 
        count++
    end
        puts "\n"
    num = 0
    outcome_types(mt, 'violation').each do |x|
        puts num
        puts ": " + x
        count++
    end 
=end

    #now, looking at the volations which are the same for speeding
    #statures
    #liscense
    #and turns, 
    #as thes are main common patterns
    #contains(tn, "violation", "speed")
    #contains(mt, "violation", "speed")

    #puts contains(tn, "violation", "investigative stop")
    #contains(mt, "violation", "statute")

    #contains(tn, "violation", "license")
    #contains(mt, "violation", "license")

    #contains(tn, "violation", "turn")
    #contains(mt, "violation", "turn")




    #FIND What is the breakdown of police interactions by race as a 
    #  percentage of the total number of interactions?

    #Starting with a hash, which returns the type of race
    #and the number of each occuration
    #p any_type_hash(tn, "subject_race")
    
    #here, I'm creating an array of strings for 
    #each race, then using a for each loop, print the number of 
    #occurances next to the race, then the repective percentages
    #coList = Array.new
    #count = 1
    #any_type_hash(tn, "subject_race").each do |x| coList.push(x) end
    
    #now that we have the total, we calc
    #this isn't working but this is what I'm trying to do
    #any_type_hash(tn, "subject_race").each do |x|
     #   puts x
      #  puts any_type_hash(tn, "subject_race")[coList[count]]
      #  puts any_type_hash(co, "subject_race")[coList[count]] / 499
      #  count +=1
   # end

    #puts "\n"
    #outcome_types(mt, "subject_race").each do |x| puts x end
    #p any_type_hash(mt, "subject_race")
    #puts "\n"



    #What is the breakdown by gender?



    #What is the min, max, mean, and median age of people who
    #interact with the police?



end