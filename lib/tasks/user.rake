namespace :users do

  desc "数据迁移"
  task run: :environment do
    OrderUser.find_each do |u|
      name_pinyin = PinYin.of_string(u.uname).join('').first(255)
      uu = User.create(phone: "修改为你的手机号#{u.id}", username: u.uname, truename: u.uname, password: "111111", pinyin: name_pinyin, email: "#{name_pinyin}@ikcrm.com", role: u.role)

      # uu = User.find_by(username: u.uname)
      Order.where(user_id: u.id).update_all(user_id: uu.id)
      Talk.all.delete_all
      Evaluation.all.delete_all

      puts uu.id
    end
  end

  desc ''
  task phone: :environment do
    hash = {"wp"=>"18616023911"}
    _hash = {}
    p _hash
    hash.each{|k, v| _hash[k.to_s] = v.to_s}

    User.find_each do |u|
      phone = _hash[u.truename]

      if phone.present?
        u.update(phone: phone)
        _hash[u.truename] = "ok"
      end
    end

    p _hash
  end
end
