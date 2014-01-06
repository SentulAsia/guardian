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
			flag = ((Time.now - portal.captured_date) / 86400).round < 20
			if flag
				portal.destroy
				print "!!!"
			end
			print "#{portal.id}..."
			STDOUT.flush
		end
		puts "Done!"
	end
end