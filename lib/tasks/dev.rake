namespace :dev do

  task fake_task: :environment do
    # Task.destroy_all
    100.times do |i|
      Task.create!(
        title: FFaker::LoremJA.word,
        content: FFaker::LoremJA.sentence,
        deadline: FFaker::Time.between(2.days.from_now, 1.years.from_now) ,
        status: [0,1,2].sample
      )
    end
    puts "have created fake tasks"
    puts "now you have #{Task.count} tasks data"
  end

end
