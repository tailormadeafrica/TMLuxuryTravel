module Refinery
  module Locations
    class Location < Refinery::Core::BaseModel
      self.table_name = 'refinery_locations'
      acts_as_nested_set

      after_save :remove_span

      extend FriendlyId
      friendly_id :title, :use => [:slugged]
    
      acts_as_indexed :fields => [:name, :description]

      validates :name, :presence => true, :uniqueness => true

      attr_accessible :name, :bread, :flag_image_id, :cover_image_id, :description, :position, :activity_ids, :gallery_id, :longitude, :latitude, :sub_name, :parent_id, :lft, :rgt, :depth, :accommodation_ids, :side_body, :url_title, :browser_title, :meta_description, :exclusion, :inclusion

      belongs_to :parent, :class_name => '::Refinery::Locations::Location'
      belongs_to :cover_image, :class_name => '::Refinery::Image'
      belongs_to :flag_image, :class_name => '::Refinery::Image'
      belongs_to :gallery, :class_name => '::Refinery::Portfolio::Gallery'
      # has_many :accommodations, :class_name => '::Refinery::Accommodations::Accommodation'
      has_and_belongs_to_many :activities, :class_name => '::Refinery::Activities::Activity', :join_table => 'refinery_activities_locations'
      has_and_belongs_to_many :posts, :class_name => 'Refinery::Blog::Post', :join_table => 'refinery_locations_posts'
      has_and_belongs_to_many :accommodations, :class_name => '::Refinery::Accommodations::Accommodation', :join_table => 'refinery_accommodations_locations'

      default_scope { order('lft') }

      def remove_span
        new_slug = self.slug.gsub("-span-","-").gsub("-span","")
        self.update_column(:slug, new_slug)


        location = self
        links = ''
        if location.parent.present?
          if location.parent.parent.present?
            links << location.parent.parent.slug.gsub('-',' ') + " "
            links << location.parent.slug.gsub('-',' ') + " "
          else
            links << location.parent.slug.gsub('-',' ') + " "
          end
        end
        links << location.slug.gsub('-',' ')

        self.update_column(:bread, links.to_s)
      end

      def roots
        where(:parent_id => 'NULL')
      end

      def title
        if url_title.present?
          url_title
        else
          name
        end
      end

    end
  end
end
