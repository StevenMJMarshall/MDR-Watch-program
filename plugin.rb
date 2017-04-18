# name: Watch Category
# about: Watches a category for all the users in a particular group
# version: 0.2
# authors: Arpit Jalan
# url: https://github.com/discourse/discourse-watch-category-mcneel

module ::WatchCategory
  def self.watch_category!
    categoryone = Category.find_by_slug("physiology-disease-injury-diagnosis")
    categorytwo = Category.find_by_slug("tracheostomy")
    categorythree = Category.find_by_slug("mechanical-ventilation")
    categoryfour = Category.find_by_slug("oxygen-therapy")
    categoryfive = Category.find_by_slug("oximetry-discussions")
    categorysix = Category.find_by_slug("respiratory-pharmacology")
    categoryseven = Category.find_by_slug("uncategorized")
    categoryeight = Category.find_by_slug("site-feedback")
    mdr_group = Group.find_by_name("MdR_Staff")

    unless categoryone.nil? || mdr_group.nil?
      mdr_group.users.each do |user|
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categoryone.id) unless watched_categories.include?(categoryone.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categorytwo.id) unless watched_categories.include?(categorytwo.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categorythree.id) unless watched_categories.include?(categorythree.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categoryfour.id) unless watched_categories.include?(categoryfour.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categoryfive.id) unless watched_categories.include?(categoryfive.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categorysix.id) unless watched_categories.include?(categorysix.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categoryseven.id) unless watched_categories.include?(categoryseven.id)
		
        watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
        CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], categoryeight.id) unless watched_categories.include?(categoryeight.id)
      end
    end

    reseller_category = Category.find_by_slug("physiology-disease-injury-diagnosis")
    reseller_group = Group.find_by_name("resellers")
    return if reseller_category.nil? || reseller_group.nil?

    reseller_group.users.each do |user|
      watched_categories = CategoryUser.lookup(user, :watching).pluck(:category_id)
      CategoryUser.set_notification_level_for_category(user, CategoryUser.notification_levels[:watching], reseller_category.id) unless watched_categories.include?(reseller_category.id)
    end
  end
end

after_initialize do
  module ::WatchCategory
    class WatchCategoryJob < ::Jobs::Scheduled
      every 1.minute

      def execute(args)
        WatchCategory.watch_category!
      end
    end
  end
end
