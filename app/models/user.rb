class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
  has_many :microposts, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower


  # before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50  }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } 
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  # 激活账户
  def activate
    # update_attribute(:activated, true)
    # update_attribute(:activated, Time.zone.now)
    update_columns(activated: FILL_IN, activated_at: FILE_IN)
  end

  # 发送激活邮件
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  #返回指定字符串的哈希摘要
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #返回一个随机令牌
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 持久化会话，在数据库记住用户
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 如果指定的令牌和摘要匹配，返回 true
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  #忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 实现动态流原型
  def feed
    Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
  end

  # 关注另一个用户
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # 取消对一个用户的关注
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 判断是否关注了某一用户
  def following?(other_user)
    following.include?(other_user)
  end

  private

    # 把邮箱地址转换成小写
    def downcase_email
      self.email = email.downcase
    end

    # 创建并赋值激活令牌、摘要
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
