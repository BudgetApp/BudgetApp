user
has_many expenses
has_many categories through expenses
id facebook_id name email facebook_token

friendship


expense
belongs_to user
belongs_to category
id amount category_id user_id


category
has_many expenses
has_many users through expenses
id title 