require "pry"
require_relative './part_1_solution.rb'

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0
  while i < coupons.length do
    cart.each do |grocery_item_hash|
      if grocery_item_hash[:item] == coupons[i][:item] && grocery_item_hash[:count] >= coupons[i][:num]
        times= grocery_item_hash[:count]/coupons[i][:num]
        grocery_item_hash[:count] -= times*coupons[i][:num]
        cart << {:item => "#{coupons[i][:item]} W/COUPON", :price => coupons[i][:cost]/ coupons[i][:num], :clearance => grocery_item_hash[:clearance], :count => times*coupons[i][:num]}
      end
    end
    i+=1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item_hash|
    if item_hash[:clearance] == true
      item_hash[:price] = item_hash[:price] *0.8
      item_hash[:price] = item_hash[:price].round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  couped_cart = apply_coupons(new_cart, coupons)
  total = apply_clearance(couped_cart).sum do |e|
    (e[:price] * e[:count]).round(2)
  end
  if total > 100
    (total = total *= 0.90).round(2)
  end
  total
end
