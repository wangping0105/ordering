class MealsController < ApplicationController
  def index
    @meals = Meal.all.group_by{|r| r[:mtype] }
    meals_groups = Meal.group(:mtype)
    @arr = []
    meals_groups.each {|m| @arr<<[m.mtype,m.mtype]}
  end

  def new
    meals_groups = Meal.group_by(:mtype)
    @arr = []
    meals_groups.each {|m| @arr<<[m,m]}
    @meal = Meal.new
  end

end
