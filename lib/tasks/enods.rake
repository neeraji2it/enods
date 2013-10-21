namespace :enod do
  desc "Remove the cart where purchased_at is null"
  task :cart => :environment do
    carts = Cart.where(["(purchased_at IS NULL or product_id IS NULL) and created_at < '#{(Time.now.utc-(30*60)).strftime('%Y-%m-%d %H:%M:%S')}'"])
    for cart in carts
      puts cart.id
      cart.destroy
    end
  end
end