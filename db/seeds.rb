# Clear existing data
User.destroy_all
Category.destroy_all
Book.destroy_all

# Seed Users
user1 = User.create!(name: "Ryan", email: "ryan@example.com")
user2 = User.create!(name: "Vahnessa", email: "vahnessa@example.com")

# Seed Categories
fiction = Category.create!(name: "Fiction")
nonfiction = Category.create!(name: "Non-fiction")

# Seed Books
Book.create!(title: "The Hobbit", author: "J.R.R. Tolkien", user: user1, category: fiction)
Book.create!(title: "Sapiens", author: "Yuval Noah Harari", user: user2, category: nonfiction)

puts "seeds planted."
