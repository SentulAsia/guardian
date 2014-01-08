namespace :status do
	desc "Set All Status to Live"
	task :live => :environment do
		puts "Set All Status to Live..."
		Portal.order('id ASC').each do |portal|
			portal.status_string = "Live"
			portal.save!
			print "#{portal.id}..."
			STDOUT.flush
		end
		puts "Done!"
	end

	desc "Calculate Total Points"
	task :points => :environment do
		puts "Calculate Total Points..."
		Portal.order('id ASC').each do |portal|
			if portal.status_string == 'Destroyed'
				age = ((Time.now - portal.captured_date) / 86400).to_i
      			bonus = 0
      			bonus = portal.bonus_points = 1 if (83..89).include?(age)
      			bonus = portal.bonus_points = 2 if (143..150).include?(age)
      			portal.age_points = 1
      			portal.total_points = 1 + bonus
				portal.save!
				print "---"
			end
			print "#{portal.id}..."
			STDOUT.flush
		end
		puts "Done!"
	end
end

namespace :time do
	desc "Set All Time to UTC"
	task :parse => :environment do
		puts "Set All Time to UTC..."
		Portal.order('id ASC').each do |portal|
			portal.captured_date = ActiveSupport::TimeZone['UTC'].parse(portal.captured_date.to_s)
			portal.day_of_150 = ActiveSupport::TimeZone['UTC'].parse(portal.day_of_150.to_s)
			portal.save!
			print "#{portal.id}..."
			STDOUT.flush
		end
		puts "Done!"
	end

	desc "Purge Portals Less Than 20 Days"
	task :purge => :environment do
		puts "Purge Portals Less Than 20 Days..."
		Portal.order('id ASC').each do |portal|
			if ((Time.now - portal.captured_date) / 86400).to_i < 20
				portal.destroy
				print "---"
			end
			print "#{portal.id}..."
			STDOUT.flush
		end
		puts "Done!"
	end
end