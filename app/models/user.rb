# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Locker

  include NoteEntryHelper

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
  
  field :notebooks,          type: Array,  default: []

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

  def notebook_ids
    if !notebooks
      update(notebooks: [])
    end
    notebooks
  end

  def create_notebook(notebook_name, notebook_description, notebook_tags, notebook_private)
    entry_owner = id
    entry_name = notebook_name
    entry_description = notebook_description
    entry_tags = text2tags(notebook_tags)
    entry_private = (!notebook_private or notebook_private != "false" ? true : false)
    notebook = Notebook.create(owner: entry_owner, name: entry_name, description: entry_description, tags: entry_tags, private: entry_private)
    update(notebooks: notebook_ids().push(notebook.id))
    notebook
  end

  def notebook_models user_id
    notebook_mdls = Notebook.where(owner: id)
    if notebook_mdls
      if user_id.to_s != id.to_s
        notebook_mdls.where(private: false)
      else
        notebook_mdls
      end
    else
      nil
    end
  end
end
