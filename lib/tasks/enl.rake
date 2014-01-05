namespace :status do
	desc "Set All Status to Live"
	task :live => :environment do
		puts "Set all status to live..."
		Portal.order('id ASC').each do |portal|
			portal.status_string = "Live"
			portal.save!
			print "#{portal.id}..."
			STDOUT.flush
		end
		puts "Done!"
	end
end