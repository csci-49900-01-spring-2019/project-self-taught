# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Locker

  field :locker_locked_at, type: Time
  field :locker_locked_until, type: Time

  locker locked_at_field: :locker_locked_at,
         locked_until_field: :locker_locked_until

  ## Database authenticatable
  field :email,              type: String, default: ''
  field :encrypted_password, type: String, default: ''

  field :first_name,         type: String, default: ''
  field :last_name,          type: String, default: ''
  field :gender,             type: String, default: ''
  field :grade,              type: String, default: ''

  ## Recoverable
  field :reset_password_token,        type: String
  field :reset_password_sent_at,      type: Time
  field :reset_password_redirect_url, type: String
  field :allow_password_change,       type: Boolean, default: false

  ## Rememberable
  field :remember_created_at,  type: Time

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  ## Required
  field :provider, type: String, default: 'email'
  field :uid,      type: String, default: ''

  ## Tokens
  field :tokens,   type: Hash, default: {}

  ## App fields
  field :books,    type: Array

  ## Validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :grade, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable
  include DeviseTokenAuth::Concerns::User

  index({ email: 1 }, { name: 'email_index', unique: true, background: true })
  index({ reset_password_token: 1 }, { name: 'reset_password_token_index', unique: true, sparse: true, background: true })
  index({ confirmation_token: 1 }, { name: 'confirmation_token_index', unique: true, sparse: true, background: true })
  index({ uid: 1, provider: 1}, { name: 'uid_provider_index', unique: true, background: true })
  # index({ unlock_token: 1 }, { name: 'unlock_token_index', unique: true, sparse: true, background: true })

  ## App functions
  def notebook_owner? notebook_id
    books && books.find(notebook_id)
  end

  def notebook_array
    if books
      Notebook.find(books)
    else
      []
    end
  end

  def notebook_create notebook_params
    notebook = Notebook.create(notebook_params)
    if books
      update(books: books.push(notebook.id))
    else
      update(books: [notebook.id])
    end
  end

  def notebook_delete notebook_id
    if books && books.find(notebook_id)
      notebook = Notebook.find(notebook_id)
      if notebook
        notebook.delete
      end
      books.delete(notebook.id)
      update(books: books)
    end
  end
end
