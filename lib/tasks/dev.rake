namespace :dev do

  task fake_user: :environment do
    # User.destroy_all
    10.times do |i|
      User.create!(
        name: FFaker::NameJA.name,
        email: "user#{i}@example.co",
        password: "123456"
      )
    end

    puts "have created fake users"
    puts "now you have #{User.count} users data"
  end

  task fake_task: :environment do
    # Task.destroy_all
    300.times do |i|
      Task.create!(
        title: FFaker::LoremJA.word,
        content: FFaker::LoremJA.sentence,
        deadline: FFaker::Time.between(2.days.from_now, 1.years.from_now),
        status: [0,1,2].sample,
        priority: [0,1,2].sample,
        user: User.all.sample
      )
    end

    Task.find_in_batches( :batch_size => 100 ) do |tasks|
      tasks.each do |task|
        names = ([''] + ["美食","時尚","教育","新聞","娛樂","音樂"].sample(2))
        task.tag_items=(names)
      end
    end

    puts "have created fake tasks"
    puts "now you have #{Task.count} tasks data"
  end

end
